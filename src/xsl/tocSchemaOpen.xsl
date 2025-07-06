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
			<link rel="STYLESHEET" type="text/css" href="../xsl/Styles.css"/>
			<script language="javascript" src="../js/functions.js"/>
			
			<body>
				<p style="margin-left:30px;font-weight:bold;font-size:30px;">
					<xsl:text>XML Schemas</xsl:text>
				</p>
				<p>
					<table border="1" width="90%" align="center" style="margin-left:10px;margin-right:30px;">
						<xsl:for-each select="schema">
							<xsl:sort select="." order="ascending"/>
							<xsl:if test="@active='yes'">
								<xsl:apply-templates select="."/>
							</xsl:if>
						</xsl:for-each>
					</table>
				</p>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="schema">
		<xsl:variable name="anchor" select="."/>
		
		<xsl:variable name="schemaRoot">
			<xsl:value-of select="@root"/>
		</xsl:variable>

		<xsl:variable name="blockId">
			<xsl:text>blk_</xsl:text>
			<xsl:value-of select="."/>
		</xsl:variable>
		
		<tr>
			<td width="170">
				<xsl:text>&#160;</xsl:text>
				<a name="blk_{$anchor}" href="../elements/{$schemaRoot}.xml" target="content" onclick="javascript:setGraphicContext('{$anchor}');">
					<xsl:value-of select="."/>
				</a>
			</td>
			<xsl:call-template name="definitionInclude">
				<xsl:with-param name="name" select="."/>
			</xsl:call-template>
		</tr>
	</xsl:template>

	<xsl:template name="definitionInclude">
		<xsl:param name="name"/>

		<xsl:for-each select="document('../definitions/schemasDefinition.xml',.)">
			<xsl:for-each select="//schema">
				<xsl:if test="name = $name">
					<td width="250">
						<xsl:text>&#160;</xsl:text>
						<xsl:apply-templates select="title"/>
					</td>
					<td>
						<xsl:apply-templates select="definition"/>
						<xsl:text>&#160;</xsl:text>
					</td>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="title">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="definition">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="br">
		<br/>
	</xsl:template>
	
</xsl:stylesheet>