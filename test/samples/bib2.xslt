<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/1999/xhtml">

	<xsl:template match="/">
		<html>
			<body>
				<div>
					<xsl:value-of select="bib/book/title"/>
				</div>
				<div>
					<xsl:value-of select="bib/book/publisher"/>
				</div>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
