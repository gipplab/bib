#!/usr/bin/env python
# ST2/ST3 compat
from __future__ import print_function
from parseTeXlog import *
import re
import sys
import os
import os.path
import subprocess
import urllib3

urllib3.disable_warnings()
from github import Github

token = os.environ['GITHUB_TOKEN']

# To accommodate both Python 2 and 3
if sys.version_info >= (3,):
    advance_iterator = next
else:
    def _advance_iterator(it):
        return it.next()


    advance_iterator = _advance_iterator

# If invoked from the command line, parse provided log file

if __name__ == '__main__':
    try:
        logfilename = '../src/tex/allRefs.log'
        if len(sys.argv) == 3:
            extra_file_ext = sys.argv[2].split(" ")
        data = open(logfilename, 'rb').read()
        root_dir = os.path.dirname(logfilename)
        errors, warnings, badboxes = parse_tex_log(data, root_dir)
        print("")
        print("Errors:")
        for err in errors:
            print(err)
        print("")
        print("Warnings:")
        unrefs = {}
        lastfile = ''
        issue_content = ''
        for warn in warnings:
            matchObj = re.match( r'(.*?).tex:(\d+): Package natbib Warning: Citation `(.*?)\' on page (\d+) undefined on input line (\d+).', warn, re.M|re.I)
            if matchObj:
                label = "\n- [ ] [" + matchObj.group(3) + "](https://github.com/usnistgov/DRMF/blob/drmf/" + matchObj.group(1) + ".tex#L" + matchObj.group(2) + ")"
                if (lastfile != matchObj.group(1) ):
                    issue_content += "\n## " + matchObj.group(1) + " \n"
                    lastfile = matchObj.group(1);
                issue_content += label
                unrefs[matchObj.group(3)] = label
        # od = collections.OrderedDict(sorted(unrefs.items()))
        if token:
            g = Github(token)
            repo = g.get_repo("ag-gipp/bib")
            repo.create_issue("Issue title", issue_content)
        # print(unrefs)
        print("")
    except Exception as e:
        import traceback

        traceback.print_exc()
