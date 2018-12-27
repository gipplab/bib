#!/usr/bin/env python
import urllib3

from parseTeXlog import *

urllib3.disable_warnings()
from github import Github

token = os.environ['GITHUB_TOKEN']

from html.parser import HTMLParser

http = urllib3.PoolManager()


class MyHTMLParser(HTMLParser):
    issue_content = ""

    def error(self, message):
        pass

    def handle_starttag(self, tag, attrs):
        # Only parse the 'anchor' tag.
        if tag == "a":
            # Check the list of defined attributes.
            for name, value in attrs:
                # If href is defined, print it.
                if name == "href":
                    if value == "":
                        self.issue_content += "- [ ] Empty link\n"
                    else:
                        # noinspection PyBroadException
                        try:
                            r = http.request('GET', value, retries=10)
                            if r.status != 200:
                                self.issue_content += "- [ ] unresolvable " + str(r.status) + " " + value + "\n"
                        except Exception:
                            import traceback

                            traceback.print_exc()
                            self.issue_content += "- [ ] unchecked " + value + "\n"


if __name__ == '__main__':
    try:
        html = 'docs/publist.html'
        data = open(html, 'rb').read()
        root_dir = os.path.dirname(html)
        parser = MyHTMLParser()
        parser.feed(data.decode('utf-8'))
        issue_content = parser.issue_content
        print("issue content is", issue_content)
        if (token and issue_content):
            g = Github(token)
            repo = g.get_repo("ag-gipp/bib")
            i = repo.create_issue("Unresolved links", issue_content)
            print("Issue created as ", i.id)
        # print(unrefs)
        print("")
    except Exception:
        import traceback

        traceback.print_exc()
