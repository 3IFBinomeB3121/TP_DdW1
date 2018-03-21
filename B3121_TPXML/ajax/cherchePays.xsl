<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Wed Mar 14 15:47:19 CET 2018 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="NomPays"/>
	<xsl:template match="/">
		<html>
			<body style="background-color:white;">
				<span>
					<h3>Nom du pays :<xsl:value-of select="//country/name[common=$NomPays]/official"/></h3>
					Capitale : <xsl:value-of select="//country[name/common=$NomPays]/capital"/>
				</span>
			</body>
		</html>
	</xsl:template>
	
		
</xsl:stylesheet>
