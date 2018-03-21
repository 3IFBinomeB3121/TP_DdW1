<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Wed Mar 14 15:47:19 CET 2018 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<body style="background-color:white;">
				<h1>Les pays du monde</h1>
			      Mise en forme par : Christophe ETIENNE, William OCCELLI (B3121)
				<p>
					<span style="text-align:center; color:blue;"><xsl:apply-templates select="countries/metadonnees"/>
					</span>
				</p>
			    <p>
					<h2>Continents (régions) :</h2>
						<xsl:variable name="lesRegions" select="countries/country/infosRegion/region[not(.=preceding::region)]"/>
							<xsl:for-each select="$lesRegions">
								<xsl:if test="node()">
									<h3><xsl:value-of select="current()"/></h3>
										Sous-régions: 
										<xsl:variable name="lesSubRegions" select="/countries/country/infosRegion/subregion[not(text()=preceding::subregion/text()) and preceding-sibling::region=current()]"/>
										<xsl:for-each select="$lesSubRegions">
											<xsl:value-of select="current()"/> (<xsl:value-of select="count(//country[infosRegion/subregion=current()])"/> pays)
											<xsl:if test="not(position()=last())">, </xsl:if>
										</xsl:for-each>
										<br/>
								</xsl:if>
								<xsl:if test="not(node())">
									<h3>Sans continent</h3>
									Sous-régions: 
									<xsl:value-of select="count(/countries/country[string-length(infosRegion/subregion)=0])"/> pays
									<br/>
								</xsl:if>
							</xsl:for-each>
				</p>
				<hr/>
				<p>
					Pays avec 7 voisins :
					<xsl:variable name="nbCountryWith7Bor" select="//country[count(borders)=7]"/>
					<xsl:for-each select="$nbCountryWith7Bor">
						<xsl:if test="not(position()=last())">
							<xsl:value-of select="name/common"/>, 
						</xsl:if>
						<xsl:if test="position()=last()">
							<xsl:value-of select="name/common"/>
						</xsl:if>
					</xsl:for-each>
					<br/>
					<br/>
					Pays ayant le plus long nom : 
					<xsl:apply-templates select="countries/country" mode="commonLePlusLong">
						<xsl:sort select="string-length(name/common)" data-type="number" order="descending"/>
					</xsl:apply-templates>
				</p>
				<hr/>
				<table border="3" width="1300" align="center"> 
					<tr>
						<td>N°</td>
						<td>Nom</td>
						<td>Capitale</td>
						<td>Continent<br/>Sous-continent</td>
						<td>Voisins</td>
						<td>Coordonnées</td>
						<td>Drapeau</td>
					</tr>
					<xsl:apply-templates select="countries/country" mode="main">
						<xsl:sort select="name/common" order="ascending"/>
					</xsl:apply-templates>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="metadonnees">
		<p style="text-align:center; color:blue;">
			Objectif : <xsl:value-of select="objectif"/>
		</p>
		<hr/>
	</xsl:template>
	
	<xsl:template match="country" mode="commonLePlusLong">
		<xsl:if test="position()=1">
			<xsl:value-of select="name/common"/>
		</xsl:if>
	</xsl:template>
							
	<xsl:template match="country" mode="main">
		<tr>
			<td>
				<xsl:value-of select="position()"/>
			</td>
			<td>
				<span style="color:green">
					<xsl:value-of select="./name/common"/>
				</span> (<xsl:value-of select="./name/official"/>)
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
