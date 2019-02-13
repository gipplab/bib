<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:bltx="http://biblatex-biber.sourceforge.net/biblatexml"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://biblatex-biber.sourceforge.net/biblatexml ">
  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="/bltx:entries">
    <xsl:for-each-group select="bltx:entry" group-by="./bltx:date">
      <xsl:text>### </xsl:text>
      <xsl:value-of select="current-grouping-key()"/>
      <xsl:text>&#xa;</xsl:text>
      <xsl:text>&#xa;</xsl:text>
      <xsl:for-each select="current-group()">
        <xsl:text>1. </xsl:text>
        <xsl:text>__</xsl:text>
        <xsl:value-of select="./bltx:title/text()"/>
        <xsl:text>__  </xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <xsl:for-each select="./bltx:names[@type='author']/bltx:name">
          <xsl:apply-templates select="./bltx:namepart[@type='given']"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="./bltx:namepart[@type='family']"/>
          <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </xsl:for-each>
        <xsl:text>  &#xa;</xsl:text>
        <xsl:if test="./bltx:booktitle">
          <xsl:text>_</xsl:text>
          <xsl:value-of select="./bltx:booktitle/text()"/>
          <xsl:text>_</xsl:text>
          <xsl:text>  &#xa;</xsl:text>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="./bltx:doi">
            <xsl:text>[DOI: </xsl:text>
            <xsl:value-of select="./bltx:doi/text()"/>
            <xsl:text>](</xsl:text>
            <xsl:text>http://dx.doi.org/</xsl:text>
            <xsl:value-of select="./bltx:doi/text()"/>
            <xsl:text>)</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>[PDF]( </xsl:text>
            <xsl:value-of select="./bltx:url/text()"/>
            <xsl:text>)</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="./bltx:usera">
          <xsl:text> </xsl:text>
          <xsl:text>[Preprint](</xsl:text>
          <xsl:value-of select="./bltx:usera/text()"/>
          <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:if test="./bltx:userb">
          <xsl:text> </xsl:text>
          <xsl:text>[Bibtex](</xsl:text>
          <xsl:value-of select="./bltx:userb/text()"/>
          <xsl:text>)</xsl:text>
        </xsl:if>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
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
