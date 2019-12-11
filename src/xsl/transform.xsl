<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:bltx="http://biblatex-biber.sourceforge.net/biblatexml"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://biblatex-biber.sourceforge.net/biblatexml ">
    <xsl:output method="xml" version="1.0"
                encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/bltx:entries">
        <xsl:for-each-group select="bltx:entry" group-by="./bltx:date">
            <xsl:element name="h4">
                <xsl:value-of select="current-grouping-key()"/>
            </xsl:element>
            <xsl:element name="ol">
                <xsl:for-each select="current-group()">
                    <xsl:element name="li">
                        <xsl:element name="strong">
                            <xsl:value-of select="./bltx:title/text()"/>
                        </xsl:element>
                        <xsl:element name="br"/>
                        <xsl:for-each select="./bltx:names[@type='author']/bltx:name">
                            <xsl:apply-templates select="./bltx:namepart[@type='given']"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="./bltx:namepart[@type='family']"/>
                            <xsl:if test="position() != last()">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:element name="br"/>
                        <xsl:if test="./bltx:booktitle">
                            <xsl:element name="em">
                                <xsl:value-of select="./bltx:booktitle/text()"/>
                            </xsl:element>
                            <xsl:element name="br"/>
                        </xsl:if>
                        <xsl:choose>
                            <xsl:when test="./bltx:doi">
                                <xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:text>http://dx.doi.org/</xsl:text>
                                        <xsl:value-of select="./bltx:doi/text()"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="class">
                                        <xsl:text>external</xsl:text>
                                    </xsl:attribute>
                                    <xsl:text>DOI: </xsl:text>
                                    <xsl:value-of select="./bltx:doi/text()"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./bltx:url/text()"/>
                                    </xsl:attribute>
                                    <!--<xsl:attribute name="class">-->
                                    <!--<xsl:text>external</xsl:text>-->
                                    <!--</xsl:attribute>-->
                                    <xsl:text>PDF</xsl:text>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="./bltx:usera">
                            <xsl:text> </xsl:text>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="./bltx:usera/text()"/>
                                </xsl:attribute>
                                <xsl:text>Preprint</xsl:text>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="./bltx:userb">
                            <xsl:text> </xsl:text>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="./bltx:userb/text()"/>
                                </xsl:attribute>
                                <xsl:text>Bibtex</xsl:text>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="./bltx:userd">
                            <xsl:text> </xsl:text>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="./bltx:userd/text()"/>
                                </xsl:attribute>
                                <xsl:text>Homepage</xsl:text>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="./bltx:userc">
                            <xsl:variable name="coreRank">
                                <xsl:value-of select="./bltx:userc/text()"/>
                            </xsl:variable>
                            <xsl:text> </xsl:text>
                            <xsl:element name="u">
                                <!-- it seems currently not possible to handle escaping. XSLT 2 does not
                                 seem to support negative look-behind regexp pattern cf.,
                                 https://lists.w3.org/Archives/Public/xsl-editors/2004OctDec/0042.html-->
                                <xsl:analyze-string select="$coreRank"
                                                    regex="^((.*?);){{2}}(.*)$">
                                    <xsl:matching-substring>
                                        <xsl:element name="a">
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="regex-group(7)"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="regex-group(4)"/>
                                        </xsl:element>
                                    </xsl:matching-substring>
                                    <xsl:non-matching-substring>
                                        <xsl:text>Core Rank </xsl:text>
                                        <xsl:value-of select="$coreRank"/>
                                        <xsl:text>.</xsl:text>
                                    </xsl:non-matching-substring>
                                </xsl:analyze-string>
                            </xsl:element>
                        </xsl:if>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each-group>
    </xsl:template>
    <xsl:template match="bltx:namepart[@type='given']">
        <xsl:choose>
            <xsl:when test="./bltx:namepart">
                <xsl:for-each select="./bltx:namepart">
                    <xsl:value-of select="./@initial"/>
                    <!--<xsl:if test="position() != last()">-->
                    <!--<xsl:text> </xsl:text>-->
                    <!--</xsl:if>-->
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="./@initial"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
