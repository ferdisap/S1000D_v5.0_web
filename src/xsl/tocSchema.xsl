<?xml version="1.0" encoding="UTF-8"?>
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
	<xsl:output method="html"/>
	
	<xsl:template match="toc">
		<html>
			<link rel="STYLESHEET" type="text/css" href="../xsl/Styles.css"/>
			<script language="javascript" src="../js/functions.js"/>
			<script language="javascript" src="../xml_schema_viewer/functions.js"/>
			
			<body>
				<p class="title">
					<xsl:text>S1000D 5.0</xsl:text>
					<br/>
					<xsl:text>Data Dictionary</xsl:text>
				</p>
				
				<p>
					<table border="0" width="100%">
						<tr>
							<td colspan="3">
								<xsl:text>Choose a category:</xsl:text>
							</td>
						</tr>
						<tr align="center">
							<td>
								<b><xsl:text>XML Schema</xsl:text></b>
							</td>
							<td>
								<a href="javascript:launchDD('elem');">
									<b><xsl:text>Elements</xsl:text></b>
								</a>
							</td>
							<td>
								<a href="javascript:launchDD('att');">
									<b><xsl:text>Attributes</xsl:text></b>
								</a>
							</td>
						</tr>
					</table>
				</p>
				<xsl:for-each select="schema">
				      <xsl:sort select="." order="ascending"/>
					<xsl:if test="@active = 'yes'">
						<xsl:apply-templates select="."/>
					</xsl:if>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="schema">
		<xsl:variable name="schemaFlat">
			<xsl:value-of select="."/>
		</xsl:variable>
		
		<xsl:variable name="schemaFlatLink">
			<xsl:text>../xml_schema_flat/</xsl:text>
			<xsl:value-of select="."/>
			<xsl:text>.xsd</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="blockId">
			<xsl:text>blk_</xsl:text>
			<xsl:value-of select="."/>
		</xsl:variable>
		
		<xsl:variable name="schemaRoot">
			<xsl:value-of select="@root"/>
		</xsl:variable>
		
		<div style="font-weight:bold;margin-left:10px;">
			<img src="../img/bluearrow_left.png" border="0">
			<xsl:attribute name="id">
				<xsl:text>img_blk_</xsl:text>
				<xsl:value-of select="."/>
			</xsl:attribute> 
			</img>
			<xsl:text>&#160;</xsl:text>
			<a href="../elements/{$schemaRoot}.xml" target="content" onclick="javascript:showHideBlock3('{$blockId}', '{$schemaFlat}');" onMouseOver="javascript:moveTo('{$blockId}');">
			<!--<a href="../elements/{$schemaRoot}.xml" target="content" onclick="javascript:setGraphicContext('{$schemaFlat}');" onMouseOver="javascript:moveTo('{$blockId}');">-->
				<xsl:value-of select="."/>
			</a>
			
			<div id="{$blockId}" style="display:none;font-weight:normal;margin-left:30px;">
				<xsl:for-each select="document($schemaFlatLink,.)">
					<xsl:for-each select="//xs:element">
						<xsl:sort select="@name" order="ascending"/>
						<xsl:variable name="anchor" select="@name"/>

						<div>
							<a href="../elements/{$anchor}.xml" target="content" onclick="javascript:setGraphicContext('{$schemaFlat}');">
								<xsl:value-of select="@name"/>
							</a>
						</div>
					</xsl:for-each>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
