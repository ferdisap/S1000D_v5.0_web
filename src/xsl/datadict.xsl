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
	<xsl:output method="html"/>
	<xsl:template match="dataDictionary">
		<html>
			<link rel="STYLESHEET" type="text/css" href="../Xsl/Styles.css"/>
			<link rel="STYLESHEET" type="text/css" href="../xml_schema_viewer/xsd_graphic.css"/>
			<script language="javascript" src="../js/functions.js"/>
			<script language="javascript" src="../xml_schema_viewer/functions.js"/>

			<head>
				<title>
					<xsl:text>S1000D - Data Dictionary</xsl:text>
				</title>
			</head>

			<xsl:variable name="elementName" select="element/@name"/>
			<body onload="javascript:init('{$elementName}');">
			<!-- <body> -->
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="element">
		<xsl:variable name="elementName" select="@name"/>
		<xsl:variable name="elementType" select="@type"/>

		<xsl:for-each select="document('../elements/elementList.xml',.)">
			<xsl:for-each select="//element">
				<xsl:if test="@name = $elementName">
					<xsl:variable name="anchor" select="@name"/>
					<xsl:variable name="blockId" select="concat('elem_', @name)"/>
					<p>
						<p>
							<i>
								<a href="javascript:returnToList('elem');">
									<img src="..\Img\bluearrow_right.png" border="0"/>
									<xsl:text>&#xA0; Return to Element List</xsl:text>
								</a>
								<!--<xsl:value-of select="@name"/>-->
							</i>
						</p>
						<div>
							<table border="0" style="border-style:thin; border-color:rgb(221,221,187);" width="100%" cellpadding="2" cellspacing="1">
								<colgroup>
									<col width="20%"/>
									<col width="80%"/>
								</colgroup>
								<xsl:call-template name="elementDefinitionInclude">
									<xsl:with-param name="name" select="@name"/>
									<xsl:with-param name="type" select="@type"/>
								</xsl:call-template>

								<tr>
									<td class="label">
										<xsl:text>Element Located in Schema</xsl:text>
									</td>
									<td>
										<xsl:call-template name="schemaLocation">
											<xsl:with-param name="elemName" select="@name"/>
										</xsl:call-template>
									</td>
								</tr>
								<tr>
									<td class="label">
										<xsl:text>Element Definition</xsl:text>
									</td>
									<td>
										<div>
											<xsl:text>&lt;xs:element </xsl:text>
											<xsl:text>name="</xsl:text>
											<xsl:value-of select="@name"/>
											<xsl:text>" type="</xsl:text>
											<xsl:value-of select="@type"/>
											<xsl:text>"/&gt;</xsl:text>
										</div>
									</td>
								</tr>
								<tr>
									<td class="label">
										<xsl:text>Element Type</xsl:text>
									</td>
									<td>
										<xsl:variable name="typeBlockId" select="concat('type_', @name)"/>
										<xsl:choose>
											<xsl:when test="contains(@type,'xs:')">
												<xsl:value-of select="@type"/>
											</xsl:when>
											<xsl:otherwise>
												<a href="javascript:showHideBlock('{$typeBlockId}');">
													<xsl:value-of select="@type"/>
												</a>
												<div id="{$typeBlockId}" style="display:none;font-family:Courier New;font-size:14px;margin-left:10px;">
													<xsl:call-template name="xsdSourceDefinitionInclude">
														<xsl:with-param name="type" select="@type"/>
													</xsl:call-template>
												</div>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
								<tr>
									<td class="label">
										<xsl:text>Element Type Redefined in Schema</xsl:text>
									</td>
									<td>
										<xsl:call-template name="xsdSourceRedefinitionInclude">
											<xsl:with-param name="type" select="string(@type)"/>
										</xsl:call-template>
									</td>
								</tr>

								<xsl:call-template name="xsdDefinitionInclude">
									<xsl:with-param name="name" select="@name"/>
									<xsl:with-param name="type" select="@type"/>
								</xsl:call-template>
							</table>
							<br/>
							<br/>
							<hr/>
						</div>
					</p>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="attribute">
		<xsl:variable name="attributeName" select="@name"/>

		<xsl:for-each select="document('../attributes/attributeList.xml',.)">
			<xsl:for-each select="//attribute">
				<xsl:if test="@name = $attributeName">
					<xsl:variable name="anchor" select="@name"/>
					<xsl:variable name="blockId" select="concat('att_', @name)"/>
					<p>
						<p>

							<i>
								<a href="javascript:returnToList('att');">
									<img src="..\Img\bluearrow_right.png" border="0"/>
									<xsl:text>&#xA0; Return to Attribute List</xsl:text>
								</a>
							</i>
						</p>
						<xsl:variable name="sourceBlockId" select="concat('source_', @name)"/>
						<i>
							<div id="{$sourceBlockId}" style="display:none;margin-left:10px;">
								<xsl:text>&lt;xs:attribute </xsl:text>
								<xsl:text>name="</xsl:text>
								<xsl:value-of select="@name"/>
								<xsl:text>" type="</xsl:text>
								<xsl:value-of select="@type"/>
								<xsl:text>"</xsl:text>
								<xsl:if test="@default">
									<xsl:text> default="</xsl:text>
									<xsl:value-of select="@default"/>
									<xsl:text>"</xsl:text>
								</xsl:if>
								<xsl:text>/&gt;</xsl:text>
							</div>
						</i>
						<div>
							<table border="0" style="border-style:thin; border-color:rgb(221,221,187);" width="100%" cellpadding="2" cellspacing="1">
								<colgroup>
									<col width="20%"/>
									<col width="80%"/>
								</colgroup>
								<xsl:call-template name="attributeDefinitionInclude">
									<xsl:with-param name="name" select="@name"/>
								</xsl:call-template>
								<tr>
									<td class="label">
										<xsl:text>Type</xsl:text>
									</td>
									<td>
										<xsl:variable name="typeBlockId" select="concat('type_', @name)"/>
										<xsl:choose>
											<xsl:when test="contains(@type,'xs:')">
												<xsl:value-of select="@type"/>
											</xsl:when>
											<xsl:otherwise>
												<a href="javascript:showHideBlock('{$typeBlockId}');">
													<xsl:value-of select="@type"/>
												</a>
												<div id="{$typeBlockId}" style="display:none;font-family:Courier New;margin-left:10px;">
													<xsl:call-template name="xsdSourceDefinitionInclude">
														<xsl:with-param name="type" select="@type"/>
													</xsl:call-template>
												</div>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
								<xsl:if test="@default">
									<tr>
										<td class="label">
											<xsl:text>Default value</xsl:text>
										</td>
										<td>
											<xsl:value-of select="@default"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:call-template name="xsdDefinitionInclude">
									<xsl:with-param name="name" select="@name"/>
									<xsl:with-param name="type" select="@type"/>
								</xsl:call-template>
							</table>
							<br/>
							<br/>
							<hr/>
						</div>
					</p>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="elementDefinitionInclude">
		<xsl:param name="name"/>
		<xsl:param name="type"/>

		<xsl:for-each select="document('../definitions/elementsDefinition.xml',.)">
			<xsl:for-each select="//element">
				<xsl:if test="name = $name">
					<tr>
						<td class="label">
							<xsl:text>Element Details</xsl:text>
						</td>
						<td class="label">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$name"/>
						</td>
					</tr>
					<tr>
						<td class="label">Graphic View</td>
						<td>
							<table width="100%">
								<tr>
									<td>
										<i>
											<xsl:text>Levels: </xsl:text>
											<input type="button" id="levelminus" value=" - " onClick="changeLevel(-1)"/>
											<xsl:text>&#xA0;</xsl:text>
											<i id="graphicLevel"/>
											<xsl:text>&#xA0;</xsl:text>
											<input type="button" id="levelplus" value=" + " onClick="changeLevel(1)"/>
											<xsl:text>&#xA0; (</xsl:text>
											<a href="javascript:displayXSDGraphic('{$name}',null);">
												<xsl:text>Master Graphic</xsl:text>
											</a>
											<xsl:text>)</xsl:text>
										</i>
									</td>
									<td align="right">
										<i id="graphicContext" style="text-align: right;"></i>
									</td>
								</tr>
							</table>

							<!--
							<i>
								<a href="javascript:displayXSDGraphic('{$name}', '2');">
									<xsl:text> Level 1 </xsl:text>
								</a>
							</i>
							<xsl:text> - </xsl:text>
							<i>
								<a href="javascript:displayXSDGraphic('{$name}', '3');">
									<xsl:text> Level 2 </xsl:text>
								</a>
							</i>
							<xsl:text> - </xsl:text>
							<i>
								<a href="javascript:displayXSDGraphic('{$name}', '4');">
									<xsl:text> Level 3 </xsl:text>
								</a>
							</i>
							-->
							<br/>
							<i>
								<xsl:call-template name="graphicRedefinition">
									<xsl:with-param name="name" select="$name"/>
									<xsl:with-param name="type" select="$type"/>
								</xsl:call-template>
							</i>
							<br/>
							<div id="XSDGraphic"/>
						</td>
					</tr>

					<tr>
						<td class="label">
							<xsl:text>Title</xsl:text>
						</td>
						<td>
							<xsl:value-of select="title"/>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:text>Definition</xsl:text>
						</td>
						<td>
							<xsl:apply-templates select="definition"/>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:text>Spec Location</xsl:text>
						</td>
						<td>
							<xsl:variable name="specLink">
								<xsl:value-of select="substring-before(substring-after(DMC, '-'), '_')"/>
							</xsl:variable>

							<!--<a href="../../../spec/pdf/{$specLink}.pdf" target="content">-->
							<xsl:text>Chapter: </xsl:text>
							<xsl:value-of select="chapter"/>
							<!--</a>-->
							<xsl:text> (Para: </xsl:text>
							<xsl:value-of select="para"/>
							<xsl:text>)</xsl:text>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="definition">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="description">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="br">
		<br/>
	</xsl:template>

	<xsl:template match="linkelement">
		<xsl:param name="blockId" select="."></xsl:param>
		<a href="../Elements/{$blockId}.xml">
			<xsl:value-of select="."/>
		</a>
	</xsl:template>

	<xsl:template name="attributeDefinitionInclude">
		<xsl:param name="name"/>

		<xsl:for-each select="document('../definitions/attributesDefinition.xml',.)">
			<xsl:for-each select="//attribute">
				<xsl:if test="name = $name">
					<tr>
						<td class="label">Attribute Details</td>
						<td class="label">
							<xsl:text> </xsl:text>
							<xsl:value-of select="$name"/>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:text>Name</xsl:text>
						</td>
						<td>
							<xsl:value-of select="name"/>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:text>Definition</xsl:text>
						</td>
						<td>
							<xsl:apply-templates select="description"/>
						</td>
					</tr>
					<tr>
						<td class="label">
							<xsl:text>Spec Location</xsl:text>
						</td>
						<td>
							<xsl:variable name="specLink">
								<xsl:value-of select="substring-before(substring-after(DMC, '-'), '_')"/>
							</xsl:variable>

							<!--<a href="../../../spec/pdf/{$specLink}.pdf" target="content">-->
							<xsl:text>Chapter: </xsl:text>
							<xsl:value-of select="chapter"/>
							<!--</a>-->
							<xsl:text> (Para: </xsl:text>
							<xsl:value-of select="para"/>
							<xsl:text>)</xsl:text>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="xsdDefinitionInclude">
		<xsl:param name="name"/>
		<xsl:param name="type"/>

		<xsl:for-each select="document('../xml_schema_master/complexTypes.xsd',.)">
			<!--<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<tr>
					<td class="label"><xsl:text>Content</xsl:text></td>
					<td><xsl:text>Complex</xsl:text></td>
					</tr>
				</xsl:if>
			</xsl:for-each>-->
			<tr>
				<td class="label">
					<xsl:text>Parent</xsl:text>
				</td>
				<td>
					<xsl:for-each select="//xs:element/@ref | //xs:attribute/@ref">
						<xsl:if test=". = $name">
							<xsl:choose>
								<xsl:when test="ancestor::xs:complexType">
									<!--<xsl:variable name="blockId" select="concat('elem_', substring(ancestor::xs:complexType/@name, 0, string-length(ancestor::xs:complexType/@name)-7))"/>
									<a href="javascript:openDD('{$blockId}');">-->
									<xsl:variable name="realId" select="ancestor::xs:complexType/@name"/>
									<xsl:variable name="blockId" select="substring(ancestor::xs:complexType/@name, 0, string-length(ancestor::xs:complexType/@name)-7)"/>
									<xsl:variable name="genericBlockId" select="substring(ancestor::xs:complexType/@name, 0, string-length(ancestor::xs:complexType/@name)-14)"/>
									<xsl:choose>
										<xsl:when test="contains($realId,'GenericElemType')">
											<xsl:for-each select="document('../xml_schema_master/complexElements.xsd',.)">
												<xsl:for-each select="//xs:element[@type=$realId]">
													<a>
														<xsl:attribute name="href">
															<xsl:text>../Elements/</xsl:text>
															<xsl:value-of select="@name"/>
															<xsl:text>.xml</xsl:text>
														</xsl:attribute>
														<xsl:value-of select="@name"/>
														<!--<xsl:if test="following-sibling::xs:element">
															<xsl:text>, </xsl:text>
														</xsl:if>-->
													</a>
													<xsl:text>, </xsl:text>
												</xsl:for-each>
											</xsl:for-each>
											<!--<a href="../Elements/{$genericBlockId}.xml">
												<xsl:value-of select="$genericBlockId"/>
											</a>-->
										</xsl:when>
										<xsl:otherwise>
											<a href="../Elements/{$blockId}.xml">
												<xsl:value-of select="substring(ancestor::xs:complexType/@name, 0, string-length(ancestor::xs:complexType/@name)-7)"/>
											</a>
											<xsl:text>, </xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="ancestor::xs:group">
									<xsl:call-template name="xsdGroupResolver">
										<xsl:with-param name="groupName" select="ancestor::xs:group/@name"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="xsdGroupResolver">
										<xsl:with-param name="groupName" select="ancestor::xs:attributeGroup/@name"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<tr>
						<td class="label">
							<xsl:text>Children</xsl:text>
						</td>
						<td>

							<xsl:for-each select=".//xs:element">
								<xsl:choose>
									<xsl:when test="contains(@ref,':')">
										<xsl:if test="./@ref[not(preceding-sibling::*/@ref = ./@ref)]">
											<xsl:value-of select="@ref"/>
											<xsl:text>, </xsl:text>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:if test="./@ref[not(preceding-sibling::*/@ref = ./@ref)]">
											<xsl:variable name="blockId" select="@ref"/>
											<a href="../Elements/{$blockId}.xml">
												<xsl:value-of select="@ref"/>
											</a>
											<xsl:text>, </xsl:text>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
							<xsl:for-each select=".//xs:group">
								<xsl:call-template name="xsdGroupDefinition">
									<xsl:with-param name="groupName" select="@ref"/>
								</xsl:call-template>
							</xsl:for-each>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<tr>
						<td class="label" valign="top">
							<br/>
							<xsl:text>Attribute</xsl:text>
						</td>
						<td>
							<br/>
							<xsl:if test=".//xs:attribute | .//xs:attributeGroup">
								<table border="1">
									<tr>
										<th>Attribute Name</th>
										<th>Use</th>
										<th>Attribute Definition</th>
									</tr>
									<xsl:for-each select=".//xs:attribute">
										<xsl:variable name="attV" select="@ref"/>
										<tr>
											<td>
												<a href="../attributes/{$attV}.xml">
													<xsl:value-of select="@ref"/>
												</a>
												<xsl:text>&#xA0;&#xA0;&#xA0;&#xA0;</xsl:text>
											</td>
											<td>
												<xsl:choose>
													<xsl:when test="@use='required'">
														<xsl:text>required</xsl:text>
													</xsl:when>
													<xsl:otherwise>
														<xsl:text>optional</xsl:text>
													</xsl:otherwise>
												</xsl:choose>
											</td>
											<td>
												<xsl:for-each select="document('../definitions/attributesDefinition.xml', .)">
													<xsl:for-each select="//attribute">
														<xsl:if test="name = $attV">
															<xsl:apply-templates select="description"/>
														</xsl:if>
													</xsl:for-each>
												</xsl:for-each>
												<xsl:text>&#xA0;</xsl:text>
											</td>
										</tr>
									</xsl:for-each>
									<xsl:for-each select=".//xs:attributeGroup">
										<xsl:call-template name="xsdAttGroupDefinition">
											<xsl:with-param name="groupName" select="@ref"/>
										</xsl:call-template>
									</xsl:for-each>
								</table>
							</xsl:if>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="xsdSourceDefinitionInclude">
		<xsl:param name="type"/>

		<xsl:for-each select="document('../xml_schema_master/complexTypes.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:text>&lt;xs:complexType </xsl:text>
					<xsl:text>name="</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>"</xsl:text>
					<xsl:if test="@mixed">
						<xsl:text> mixed="</xsl:text>
						<xsl:value-of select="@mixed"/>
						<xsl:text>"</xsl:text>
					</xsl:if>
					<xsl:text>&gt;</xsl:text>
					<div style="margin-left:20px;font-family:Courier New;">
						<xsl:apply-templates/>
					</div>
					<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:for-each select="document('../xml_schema_master/simpleTypes.xsd',.)">
			<xsl:for-each select="//xs:simpleType">
				<xsl:if test="@name = $type">
					<xsl:text>&lt;xs:simpleType </xsl:text>
					<xsl:text>name="</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>"&gt;</xsl:text>
					<div style="margin-left:20px;font-family:Courier New;">
						<xsl:apply-templates/>
					</div>
					<xsl:text>&lt;/xs:simpleType&gt;</xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="xsdSourceRedefinitionInclude">
		<xsl:param name="type"/>
		<!-- dibawah ini tidak di modifikasi -->
		 <!-- sebelumnya url = ../xml_schema_master/appliccrossreftableSchema.xsd -->
		<xsl:for-each select="document('../xml_schema_flat/appliccrossreftable.xsd',.)">
			<xsl:value-of select="//xs:complexType[@name = $type]"/>
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('appliccrossreftable_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>appliccrossreftable, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/brdoc.xsd',.)">
			<xsl:value-of select="//xs:complexType[@name = $type]"/>
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('brdoc_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>brdoc, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/brex.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('brex_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>brex, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/checklist.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('checklist_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>checklist, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/comment.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('comment_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>comment, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/comrep.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('comrep_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>comrep, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/condcrossreftable.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('condcrossreftable_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>condcrossreftable, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/container.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('container_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>container, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/crew.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('crew_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>crew, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/ddn.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('ddn_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>ddn, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/descript.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('descript_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>descript, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/dml.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('dml_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>dml, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/frontmatter.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('frontmatter_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>frontmatter, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/fault.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('fault_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>fault, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/ipd.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('ipd_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>ipd, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/learning.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('learning_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>learning, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/pm.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('pm_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>pm, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/prdcrossreftable.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('prdcrossreftable_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>prdcrossreftable, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/proced.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('proced_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>proced, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/process.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('process_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>process, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/sb.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('sb_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>sb, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/schedul.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('schedul_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>schedul, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/scocontent.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('scocontent_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>scocontent, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/scormcontentpackage.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('scormcontentpackage_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>scormcontentpackage, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/update.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('update_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>update, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/wrngdata.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('wrngdata_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>wrngdata, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/wrngflds.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('wrngflds_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>wrngflds, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
						<xsl:text>name="</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="@mixed">
							<xsl:text> mixed="</xsl:text>
							<xsl:value-of select="@mixed"/>
							<xsl:text>"</xsl:text>
						</xsl:if>
						<xsl:text>&gt;</xsl:text>
						<div style="margin-left:20px;font-family:Courier New;">
							<xsl:apply-templates/>
						</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/>
						<br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/xcf.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<xsl:variable name="typeBlockId" select="concat('xcf_refdeftype_', @name)"/>
					<a href="javascript:showHideBlock('{$typeBlockId}');">
						<xsl:text>xcf, </xsl:text>
					</a>
					<div id="{$typeBlockId}" style="display:none;font-style:italic;margin-left:10px;">
						<xsl:text>&lt;xs:complexType </xsl:text>
							<xsl:text>name="</xsl:text>
							<xsl:value-of select="@name"/>
							<xsl:text>"</xsl:text>
							<xsl:if test="@mixed">
								<xsl:text> mixed="</xsl:text>
								<xsl:value-of select="@mixed"/>
								<xsl:text>"</xsl:text>
							</xsl:if>
							<xsl:text>&gt;</xsl:text>
							<div style="margin-left:20px;font-family:Courier New;">
								<xsl:apply-templates/>
							</div>
						<xsl:text>&lt;/xs:complexType&gt;</xsl:text>
						<br/><br/>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="graphicRedefinition">
		<xsl:param name="name"/>
		<xsl:param name="type"/>

		<xsl:for-each select="document('../xml_schema_master/appliccrossreftableSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'appliccrossreftable.xsd');">
						<xsl:text>appliccrossreftable, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/brexSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'brex.xsd');">
						<xsl:text>brex, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/checklistSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'checklist.xsd');">
						<xsl:text>checklist, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/commentSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'comment.xsd');">
						<xsl:text>comment, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/comrepSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'comrep.xsd');">
						<xsl:text>comrep, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/condcrossreftableSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'condcrossreftable.xsd');">
						<xsl:text>condcrossreftable, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/containerSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'container.xsd');">
						<xsl:text>container, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/crewSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'crew.xsd');">
						<xsl:text>crew, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/ddnSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'ddn.xsd');">
						<xsl:text>ddn, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/descriptSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'descript.xsd');">
						<xsl:text>descript, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/dmlSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'dml.xsd');">
						<xsl:text>dml, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/frontmatterSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'frontmatter.xsd');">
						<xsl:text>frontmatter, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/faultSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'fault.xsd');">
						<xsl:text>fault, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/ipdSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'ipd.xsd');">
						<xsl:text>ipd, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/learningSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'learning.xsd');">
						<xsl:text>learning, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/pmSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'pm.xsd');">
						<xsl:text>pm, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/prdcrossreftableSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'prdcrossreftable.xsd');">
						<xsl:text>prdcrossreftable, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/procedSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'proced.xsd');">
						<xsl:text>proced, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/processSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'process.xsd');">
						<xsl:text>process, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/sbSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'sb.xsd');">
						<xsl:text>sb, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/schedulSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'schedul.xsd');">
						<xsl:text>schedul, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/scocontentSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'scocontent.xsd');">
						<xsl:text>scocontent, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/scormcontentpackageSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'scormcontentpackage.xsd');">
						<xsl:text>scormcontentpackage, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/updateSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'update.xsd');">
						<xsl:text>update, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/wrngdataSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'wrngdata.xsd');">
						<xsl:text>wrngdata, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_master/wrngfldsSchema.xsd',.)">
			<xsl:for-each select="//xs:complexType">
				<xsl:if test="@name = $type">
					<a href="javascript:displayXSDGraphicFlat('{$name}', 'wrngflds.xsd');">
						<xsl:text>wrngflds, </xsl:text>
					</a>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="xsdGroupDefinition">
		<xsl:param name="groupName"/>

		<xsl:for-each select="document('../xml_schema_master/complexTypes.xsd',.)">
			<xsl:for-each select="//xs:group">
				<xsl:if test="@name = $groupName">
					<xsl:for-each select=".//xs:element">
						<xsl:variable name="blockId" select="@ref"/>
						<a href="../Elements/{$blockId}.xml">
							<xsl:value-of select="@ref"/>
						</a>
						<xsl:text>, </xsl:text>
					</xsl:for-each>
					<xsl:for-each select=".//xs:group">
						<xsl:call-template name="xsdGroupDefinition">
							<xsl:with-param name="groupName" select="@ref"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="xsdGroupResolver">
		<xsl:param name="groupName"/>

		<xsl:for-each select="document('../xml_schema_master/complexTypes.xsd',.)">
			<xsl:for-each select="//xs:group/@ref | //xs:attributeGroup/@ref">
				<xsl:if test=". = $groupName">
					<xsl:choose>
						<xsl:when test="ancestor::xs:complexType">
							<xsl:variable name="blockId" select="substring(ancestor::xs:complexType/@name, 0, string-length(ancestor::xs:complexType/@name)-7)"/>
							<a href="../Elements/{$blockId}.xml">
								<xsl:value-of select="substring(ancestor::xs:complexType/@name, 0, string-length(ancestor::xs:complexType/@name)-7)"/>
							</a>
							<xsl:text>, </xsl:text>
						</xsl:when>
						<xsl:when test="ancestor::xs:group">
							<xsl:call-template name="xsdGroupResolver">
								<xsl:with-param name="groupName" select="ancestor::xs:group/@name"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="ancestor::xs:attributeGroup">
							<xsl:call-template name="xsdGroupResolver">
								<xsl:with-param name="groupName" select="ancestor::xs:attributeGroup/@name"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="xsdAttGroupDefinition">
		<xsl:param name="groupName"/>

		<xsl:for-each select="document('../xml_schema_master/attributeGroups.xsd',.)">
			<xsl:for-each select="//xs:attributeGroup">
				<xsl:if test="@name = $groupName">
					<xsl:for-each select="xs:attribute">
						<xsl:variable name="attV" select="@ref"/>
						<tr>
							<td>
								<a href="../attributes/{$attV}.xml">
									<xsl:value-of select="@ref"/>
								</a>
								<xsl:text>&#xA0;&#xA0;&#xA0;&#xA0;</xsl:text>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="@use='required'">
										<xsl:text>required</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>optional </xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:for-each select="document('../definitions/attributesDefinition.xml', .)">
									<xsl:for-each select="//attribute">
										<xsl:if test="name = $attV">
											<xsl:apply-templates select="description"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
								<xsl:text>&#xA0;</xsl:text>
							</td>
						</tr>
					</xsl:for-each>
					<xsl:for-each select="xs:attributeGroup">
						<xsl:call-template name="xsdAttGroupDefinition">
							<xsl:with-param name="groupName" select="@ref"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="schemaLocation">
		<xsl:param name="elemName"/>

		<xsl:for-each select="document('../xml_schema_flat/appliccrossreftable.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>appliccrossreftable, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/brex.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>brex, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/checklist.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>checklist, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/comment.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>comment, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/comrep.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>comrep, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/condcrossreftable.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>condcrossreftable, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/container.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>container, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/crew.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>crew, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/ddn.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>ddn, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/descript.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>descript, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/dml.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>dml, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/fault.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>fault, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/frontmatter.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>frontmatter, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/ipd.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>ipd, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/learning.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>learning, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/pm.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>pm, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/prdcrossreftable.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>prdcrossreftable, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/proced.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>proced, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/process.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>process, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/sb.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>sb, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/schedul.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>schedul, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/scocontent.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>scocontent, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/scormcontentpackage.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>scormcontentpackage, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/update.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>update, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/wrngdata.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>wrngdata, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="document('../xml_schema_flat/wrngflds.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>wrngflds, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>
		<!--<xsl:for-each select="document('../xml_schema_flat/xcf.xsd',.)">
			<xsl:for-each select="//xs:element">
				<xsl:if test="@name = $elemName">
					<xsl:text>xcf, </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>-->
	</xsl:template>

	<xsl:template match="xs:simpleType">
		<xsl:text>&lt;xs:simpleType </xsl:text>
		<xsl:text>name="</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:text>"</xsl:text>
		<xsl:text>&gt;</xsl:text>
		<div style="margin-left:20px;font-family:Courier New;">
			<xsl:apply-templates/>
		</div>
		<xsl:text>&lt;/xs:simpleType&gt;</xsl:text>
	</xsl:template>

	<xsl:template match="xs:sequence">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:sequence</xsl:text>
			<xsl:if test="@minOccurs">
				<xsl:text> minOccurs="</xsl:text>
				<xsl:value-of select="@minOccurs"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:if test="@maxOccurs">
				<xsl:text> maxOccurs="</xsl:text>
				<xsl:value-of select="@maxOccurs"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:text>&gt;</xsl:text>
			<div style="margin-left:20px;font-family:Courier New;">
				<xsl:apply-templates/>
			</div>
			<xsl:text>&lt;/xs:sequence&gt;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:choice">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:choice</xsl:text>
			<xsl:if test="@minOccurs">
				<xsl:text> minOccurs="</xsl:text>
				<xsl:value-of select="@minOccurs"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:if test="@maxOccurs">
				<xsl:text> maxOccurs="</xsl:text>
				<xsl:value-of select="@maxOccurs"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:text>&gt;</xsl:text>
			<div style="margin-left:20px;font-family:Courier New;">
				<xsl:apply-templates/>
			</div>
			<xsl:text>&lt;/xs:choice&gt;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:element">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:element </xsl:text>
			<xsl:text>ref="</xsl:text>
			<xsl:value-of select="@ref"/>
			<xsl:text>"</xsl:text>
			<xsl:if test="@minOccurs">
				<xsl:text> minOccurs="</xsl:text>
				<xsl:value-of select="@minOccurs"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:if test="@maxOccurs">
				<xsl:text> maxOccurs="</xsl:text>
				<xsl:value-of select="@maxOccurs"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:text>/&gt;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:group">
		<xsl:text>&lt;xs:group </xsl:text>
		<xsl:choose>
			<xsl:when test="@ref">
				<xsl:text>ref="</xsl:text>
				<xsl:value-of select="@ref"/>
				<xsl:text>"</xsl:text>

				<xsl:if test="@minOccurs">
					<xsl:text> minOccurs="</xsl:text>
					<xsl:value-of select="@minOccurs"/>
					<xsl:text>"</xsl:text>
				</xsl:if>
				<xsl:if test="@maxOccurs">
					<xsl:text> maxOccurs="</xsl:text>
					<xsl:value-of select="@maxOccurs"/>
					<xsl:text>"</xsl:text>
				</xsl:if>
				<xsl:text>/&gt;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>name="</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>"</xsl:text>
				<xsl:text>&gt;</xsl:text>

				<xsl:apply-templates/>
				<xsl:text>&lt;/xs:group&gt;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xs:attribute">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:attribute </xsl:text>
			<xsl:text>ref="</xsl:text>
			<xsl:value-of select="@ref"/>
			<xsl:text>"</xsl:text>
			<xsl:if test="@use">
				<xsl:text> use="</xsl:text>
				<xsl:value-of select="@use"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:if test="@default">
				<xsl:text> default="</xsl:text>
				<xsl:value-of select="@default"/>
				<xsl:text>"</xsl:text>
			</xsl:if>
			<xsl:text>/&gt;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:attributeGroup">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:attributeGroup </xsl:text>
			<xsl:choose>
				<xsl:when test="@ref">
					<xsl:text>ref="</xsl:text>
					<xsl:value-of select="@ref"/>
					<xsl:text>"</xsl:text>
					<xsl:text>/&gt;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>name="</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>"</xsl:text>
					<xsl:text>&gt;</xsl:text>
					<xsl:apply-templates/>
					<xsl:text>&lt;/xs:attributeGroup&gt;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template match="xs:restriction">
		<xsl:text>&lt;xs:restriction </xsl:text>
		<xsl:text>base="</xsl:text>
		<xsl:value-of select="@base"/>
		<xsl:text>"</xsl:text>
		<xsl:text>&gt;</xsl:text>

		<div style="margin-left:20px;font-family:Courier New;">
			<xsl:apply-templates/>
		</div>
		<xsl:text>&lt;/xs:restriction&gt;</xsl:text>
	</xsl:template>

	<xsl:template match="xs:enumeration">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:enumeration </xsl:text>
			<xsl:text>value="</xsl:text>
			<xsl:value-of select="@value"/>
			<xsl:text>"</xsl:text>
			<xsl:text>/&gt;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:pattern">
		<div style="font-family:Courier New;">
			<xsl:text>&lt;xs:pattern </xsl:text>
			<xsl:text>value="</xsl:text>
			<xsl:value-of select="@value"/>
			<xsl:text>"</xsl:text>
			<xsl:text>/&gt;</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:totalDigits">
		<xsl:text>&lt;xs:totalDigits </xsl:text>
		<xsl:text>value="</xsl:text>
		<xsl:value-of select="@value"/>
		<xsl:text>"</xsl:text>
		<xsl:text>/&gt;</xsl:text>
		<xsl:if test="@fixed">
			<xsl:text> fixed="</xsl:text>
			<xsl:value-of select="@fixed"/>
			<xsl:text>"</xsl:text>
		</xsl:if>
		<xsl:text>/&gt;</xsl:text>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///e:/projekte/S1000D_Work/data_dictionary/data_dictionary_42-000_03/Files/Elements/logo.xml" htmlbaseurl="" outputurl="" processortype="saxon8"
		          useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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