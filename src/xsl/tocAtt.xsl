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
			
			<body>
				<p class="title">
					<xsl:text>S1000D 5.0</xsl:text>
					<br/>
					<xsl:text>Data Dictionary</xsl:text>
				</p>
				
				<p>
					<table border="0" width="100%">
						<tr>
							<td colspan="2">
								<xsl:text>Choose a category:</xsl:text>
							</td>
						</tr>
						<tr align="center">
							<td>
								<b><xsl:text>Attributes</xsl:text></b>
							</td><td>
								<a href="javascript:launchDD('schema');">
									<b><xsl:text>XML Schema</xsl:text></b>
								</a>
							</td>
							<td>
								<a href="javascript:launchDD('elem');">
									<b><xsl:text>Elements</xsl:text></b>
								</a>
							</td>
							
						</tr>
					</table>
				</p>
				<xsl:for-each select="attributes">
				      <xsl:sort select="@startBy" order="ascending"/>
				      <xsl:apply-templates select="."/>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="attributes">
		<xsl:variable name="blockId">
			<xsl:text>blk_</xsl:text>
			<xsl:value-of select="@startBy"/>
		</xsl:variable>
		
		<p style="font-weight:bold;margin-left:10px;">
			<img src="../img/bluearrow_left.png" border="0">
				<xsl:attribute name="id">
					<xsl:text>img_blk_</xsl:text>
					<xsl:value-of select="@startBy"/>
				</xsl:attribute> 
			</img>
			<xsl:text>&#160;</xsl:text>
			<a href="javascript:showHideBlock2('{$blockId}');" onMouseOver="javascript:moveTo('{$blockId}');">
				<xsl:value-of select="@startBy"/>
			</a>
			
			<div id="{$blockId}" style="display:none;margin-left:30px;">
				<xsl:for-each select="attribute">
					<xsl:sort select="." order="ascending"/>
					<xsl:apply-templates select="."/>
				</xsl:for-each>
			</div>
		</p>
	</xsl:template>
	
	<xsl:template match="attribute">
		<xsl:variable name="anchor" select="."/>

		<div>
			<a href="../attributes/{$anchor}.xml" target="content">
				<xsl:value-of select="."/>
			</a>
		</div>
	</xsl:template>
	
	<xsl:template match="description">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="br">
		<br/>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\toc\tocAtt.XML" htmlbaseurl="" outputurl="..\..\work\attribute_toc.html" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->