<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Wed Mar 14 15:47:19 CET 2018 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<body style="background-color:white;">
				<h1>Les pays du monde</h1>
			      Mise en forme par : Christophe ETIENNE, William OCCELLI (B3121)
			      <xsl:apply-templates select="countries/metadonnees"/>
				  <table border="3" width="1200" align="center"> 
					<tr>
						<td>N°</td>
						<td>Nom</td>
						<td>Capitale</td>
						<td>Continent<br/>Sous-continent</td>
						<td>Voisins</td>
						<td>Coordonnées</td>
						<td>Drapeau</td>
					</tr>
					
					<xsl:apply-templates select="countries/country">
						<xsl:sort select="name/common" order="ascending"/>
					</xsl:apply-templates>
				  </table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="metadonnees">
		<p style="text-align:center; color:blue;">
			Objectif : <xsl:value-of select="objectif"/>
		</p><hr/>
	</xsl:template>
	
		
							
	<xsl:template match="country">
			
				<tr>
						<td>
							<xsl:value-of select="position()"/>
						</td>
						<td>
							<xsl:value-of select="./name/common"/> (<xsl:value-of select="./name/official"/>)
							<xsl:if test="name/native_name/@lang='fra'">
								<br/>
								<SPAN style="color:brown">Nom français: <xsl:value-of select="./name/native_name/official"/></SPAN>
							</xsl:if>
						</td>
						<td>
							<xsl:value-of select="./capital"/>
						</td>
						<td><xsl:value-of select="./infosRegion/region"/>
							<br/>
							<xsl:value-of select="./infosRegion/subregion"/>
						</td>
						<td>
							<xsl:for-each select="borders">
								<xsl:value-of select="//country/codes[cca3=current()]/parent::country/name/common"/>
								<xsl:if test="not(position()=last())">, </xsl:if>
							</xsl:for-each>
						</td>
						<td>
							Latitude : <xsl:value-of select="coordinates/@lat"/>
							<br/>
							Longitude : <xsl:value-of select="coordinates/@long"/>
						</td>
						<td>
							<xsl:variable name="codecca2" select="codes/cca2"/>
							<xsl:variable name="codecca2minuscule" select="translate($codecca2, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
							<xsl:variable name="sourceDrapeau" select="concat('http://www.geonames.org/flags/x/',$codecca2minuscule,'.gif')"/>
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
						</td>
				</tr>
	</xsl:template>
</xsl:stylesheet>
