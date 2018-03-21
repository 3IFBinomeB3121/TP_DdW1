<?xml version="1.0" encoding="UTF-8"?>


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="NomPays"/>
	<xsl:template match="/">
		<html>
			<body style="background-color:white;">
				<span>
					<table border="3" width="600px" align="center">
						<tr>
							<td>
								<span style="text-align:center"><h3>Nom du pays</h3></span>
							</td>
							<td><span style="text-align:center"><h4>Capitale</h4></span></td>
							<td><span style="text-align:center"><h4>Drapeau</h4></span></td>
						</tr>
						<tr>
							<td>
								<span style="text-align:center"><h3><xsl:value-of select="//country/name[common=$NomPays]/official"/></h3></span>
							</td>
							<td>
								<span style="text-align:center"><h4><xsl:value-of select="//country[name/common=$NomPays]/capital"/></h4></span>
							</td>
							<td>
								<xsl:variable name="codecca2" select="//country[name/common=$NomPays]/codes/cca2"/>
								<xsl:variable name="codecca2minuscule" select="translate($codecca2, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
								<xsl:variable name="sourceDrapeau" select="concat('http://www.geonames.org/flags/x/',$codecca2minuscule,'.gif')"/>
								<SPAN style="text-align:center">
									<p>
									<img>
										<xsl:attribute name="src">
											<xsl:value-of select="$sourceDrapeau"/>
										</xsl:attribute>
										<xsl:attribute name="alt">
										</xsl:attribute>
										<xsl:attribute name="height">
											<xsl:value-of select='40'/>
										</xsl:attribute>
										<xsl:attribute name="width">
											<xsl:value-of select='60'/>
										</xsl:attribute>
									</img>
									</p>
								</SPAN>
							</td>
						</tr>
					</table>
					
				</span>
			</body>
		</html>
	</xsl:template>
	
		
</xsl:stylesheet>
