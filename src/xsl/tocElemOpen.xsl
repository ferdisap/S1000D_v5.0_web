<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Copyright:
	Copyright (C) 2008 by each of the following organizations:
	1.  AeroSpace and Defence Industries Associations of Europe - ASD.
	2.  Ministries of Defence of the member countries of ASD.

	Limitations of Liability:

	1.  This material is provided "As Is" and neither ASD nor any person who has contributed to the creation, revision or maintenance of the material makes any representations or warranties, express or implied, including but not limited to, warranties of merchantability or fitness for any particular purpose.
	2.  Neither ASD nor any person who has contributed to the creation, revision or maintenance of this material shall be liable for any direct, indirect, special or consequential damages or any other liability arising from any use of this material.
	3.  Revisions to this document may occur after its issuance.  The user is responsible for determining if revisions to the material contained in this document have occurred and are applicable. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method = "html"/>
	
	<xsl:template match="toc">
		<html>
			<link rel="STYLESHEET" type="text/css" href="../Xsl/Styles.css"/>
			<script language="javascript" src="../js/functions.js"/>
			
			<body>
				<p style="margin-left:30px;font-weight:bold;font-size:30px;">
					<xsl:text>Elements</xsl:text>
				</p>
				<xsl:for-each select="elements">
				      <xsl:sort select="@startBy" order="ascending"/>
				      <xsl:apply-templates select="."/>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="elements">
		<p>
			<div style="margin-left:30px;font-weight:bold;font-size:30px;">
				<xsl:variable name="anchorGroup" select="@startBy"/>
				<a name="blk_{$anchorGroup}">
					<xsl:value-of select="$anchorGroup"/>
				</a>
			</div>

			<xsl:for-each select="elements">
			      <xsl:sort select="//element/." order="ascending"/>
				      <xsl:apply-templates select="."/>
			</xsl:for-each>
			<table border="1" width="90%" align="center" style="margin-left:10px;margin-right:30px;">
				<xsl:for-each select="element">
					<xsl:sort select="." order="ascending"/>
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</table>
			<br/><br/>
		</p>
	</xsl:template>

	<xsl:template match="element">
		<xsl:variable name="anchor" select="."/>

		<tr>
			<td width="200">
				<a href="../elements/{$anchor}.xml" target="content">
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="."/>
				</a>
			</td>
			<td>
				<xsl:call-template name="definitionInclude">
					<xsl:with-param name="name" select="."/>
				</xsl:call-template>
				<xsl:text>&#160;</xsl:text>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="definitionInclude">
		<xsl:param name="name"/>

		<xsl:for-each select="document('../definitions/elementsDefinition.xml',.)">
			<xsl:for-each select="//element">
				<xsl:if test="name = $name">
					<xsl:if test="@validationStatus!='Excluded'">
						<xsl:apply-templates select="definition"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="definition">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="br">
		<br/>
	</xsl:template>
</xsl:stylesheet>