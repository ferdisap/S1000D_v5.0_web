<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:var="http://www.w3.org/2001/dummy">
	<xsl:output method="html"/>
	<xsl:param name="startElement" select="'dmodule'"/>
	<xsl:param name="maxLevel" select="3"/>
	<xsl:param name="flatSchema"/>
	
	<xsl:variable name="debug" select="'FALSE'"/>
	<!--<xsl:variable name="debug" select="'TRUE'"/>-->
	<xsl:variable name="graphicFolder" select="'../xml_schema_viewer/graphic_classic'"/>
	<xsl:variable name="flatSchemaPath" select="'../xml_schema_flat'"/>
	<xsl:variable name="lomSchemaPath" select="'../lom_schema'"/>

	<!--<xsl:variable name="flatSchemaFile" select="concat($flatSchemaPath, '/process.xsd')"/>-->
	<xsl:variable name="flatSchemaFile" select="concat($flatSchemaPath, '/', $flatSchema)"/>
	
	<xsl:variable name="ddnSchemaFile" select="concat($flatSchemaPath,'/ddn.xsd')"/>
	<xsl:variable name="commentSchemaFile" select="concat($flatSchemaPath,'/comment.xsd')"/>
	<xsl:variable name="dmlSchemaFile" select="concat($flatSchemaPath,'/dml.xsd')"/>
	<xsl:variable name="pmSchemaFile" select="concat($flatSchemaPath,'/pm.xsd')"/>
	<xsl:variable name="updateSchemaFile" select="concat($flatSchemaPath,'/update.xsd')"/>
	
	<!--<xsl:variable name="s1000dSchemaCollection" select="document($descriptSchemaFile) | document($ddnSchemaFile) | document($dmlSchemaFile) | document($pmSchemaFile) | document($commentSchemaFile) | document($updateSchemaFile)"/>-->
	<xsl:variable name="s1000dSchemaCollection" select="document($flatSchemaFile)"/>
	
	<xsl:variable name="rdfSchema" select="document(concat($flatSchemaPath,'/rdf.xsd'))"/>
	<xsl:variable name="dcSchema" select="document(concat($flatSchemaPath,'/dc.xsd'))"/>
	<xsl:variable name="lomAnyElementSchemaFile" select="concat($lomSchemaPath,'/common/anyElement.xsd')"/>
	<xsl:variable name="lomDataTypesSchemaFile" select="concat($lomSchemaPath,'/common/dataTypes.xsd')"/>
	<xsl:variable name="lomElementNamesSchemaFile" select="concat($lomSchemaPath,'/common/elementNames.xsd')"/>
	<xsl:variable name="lomElementTypesSchemaFile" select="concat($lomSchemaPath,'/common/elementTypes.xsd')"/>
	<xsl:variable name="lomRootElementSchemaFile" select="concat($lomSchemaPath,'/common/rootElement.xsd')"/>
	<xsl:variable name="lomVocabValuesSchemaFile" select="concat($lomSchemaPath,'/common/vocabValues.xsd')"/>
	<xsl:variable name="lomVocabTypesSchemaFile" select="concat($lomSchemaPath,'/common/vocabTypes.xsd')"/>
	<xsl:variable name="lomSchemaCollection" select="document($lomAnyElementSchemaFile) | document($lomDataTypesSchemaFile) | document($lomElementNamesSchemaFile) | document($lomElementTypesSchemaFile) | document($lomRootElementSchemaFile) | document($lomVocabValuesSchemaFile) | document($lomVocabTypesSchemaFile)"/>
	<xsl:template match="/xsd">
    <div>
				<xsl:apply-templates select="$s1000dSchemaCollection/xs:schema/xs:element[@name=$startElement] | $s1000dSchemaCollection/xs:schema/xs:group[@name=$startElement] | $rdfSchema/xs:schema/xs:element[@name=$startElement]" mode="node">
					<xsl:with-param name="level" select="1"/>
				</xsl:apply-templates>
    </div>
		
	</xsl:template>
	<xsl:template name="elementApplyTemplate">
		<xsl:param name="schemaRef"/>
		<xsl:param name="elementRef"/>
		<xsl:param name="schema"/>
		<xsl:param name="level"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            ELEMENT APPLY TEMPLATE schemaRef = <xsl:value-of select="$schemaRef"/> elementRef = <xsl:value-of select="$elementRef"/> schema = <xsl:value-of select="$schema"/> level = <xsl:value-of select="$level"/> minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs <xsl:value-of select="$maxOccurs"/>
			<br/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$schemaRef = 'S1000D'">
				<xsl:apply-templates select="$s1000dSchemaCollection/xs:schema/xs:element[@name=$elementRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$schemaRef = 'rdf'">
				<xsl:apply-templates select="$rdfSchema/xs:schema/xs:element[@name=$elementRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$schemaRef = 'dc'">
				<xsl:apply-templates select="$dcSchema/xs:schema/xs:element[@name=$elementRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$schemaRef = 'lom'">
				<xsl:apply-templates select="$lomSchemaCollection/xs:schema/xs:complexType[@name=$elementRef]" mode="node">
					<xsl:with-param name="caption" select="$elementRef"/>
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="groupApplyTemplate">
		<xsl:param name="schemaRef"/>
		<xsl:param name="groupRef"/>
		<xsl:param name="schema"/>
		<xsl:param name="level"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:choose>
			<xsl:when test="$schemaRef = 'S1000D'">
				<xsl:apply-templates select="$s1000dSchemaCollection/xs:schema/xs:group[@name=$groupRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$schemaRef = 'rdf'">
				<xsl:apply-templates select="$rdfSchema/xs:schema/xs:group[@name=$groupRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$schemaRef = 'dc'">
				<xsl:apply-templates select="$dcSchema/xs:schema/xs:group[@name=$groupRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$schemaRef = 'lom'">
				<xsl:apply-templates select="$lomSchemaCollection/xs:schema/xs:group[@name=$groupRef]" mode="node">
					<xsl:with-param name="schema" select="$schemaRef"/>
					<xsl:with-param name="level" select="$level"/>
					<xsl:with-param name="minOccurs" select="$minOccurs"/>
					<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				</xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="elementOut">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="'?'"/>
		<xsl:param name="caption" select="'?'"/>
		<xsl:param name="type" select="'?'"/>
		<xsl:param name="mixed" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:param name="childrenElementCount"/>
		<xsl:param name="isGroup" select="'false'"/>
		<xsl:if test="$debug = 'TRUE'">
            ELEMENT OUT caption = <xsl:value-of select="$caption"/> type = <xsl:value-of select="$type"/> minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> childrenElementCount = <xsl:value-of select="$childrenElementCount"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:variable name="elementOrGroup">
			<xsl:choose>
				<xsl:when test="$isGroup = 'false'">element</xsl:when>
				<xsl:otherwise>elementgroup</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="elementRequired">
			<xsl:choose>
				<xsl:when test="$minOccurs = 0">optional</xsl:when>
				<xsl:otherwise>mandatory</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="elementRepeatable">
			<xsl:choose>
				<xsl:when test="$maxOccurs = 'unbounded'">any</xsl:when>
				<xsl:otherwise>one</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="elementLeftType">
			<xsl:choose>
				<xsl:when test="starts-with($type,'xs:') or starts-with($type,'dc:') or $mixed='true'">textual</xsl:when>
				<xsl:otherwise>empty</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="elementRightType">
			<xsl:choose>
				<xsl:when test="count(./*[not(starts-with(name(), 'xs:attribute'))]) = 0">withnosub</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$level &lt; $maxLevel">withopensub</xsl:when>
						<xsl:otherwise>withsub</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="elementRightClass">
			<xsl:choose>
				<xsl:when test="$elementRepeatable = 'one' and $elementRightType = 'withnosub'">element_right_small</xsl:when>
				<xsl:otherwise>element_right_large</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<table class="composition_table" cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="element_left">
						<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/', $elementOrGroup, '_left_', $elementLeftType,'_',$elementRequired,'_',$elementRepeatable,'.png')"/></xsl:attribute>
					</td>
					<td class="element_body">
						<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/', $elementOrGroup, '_body_',$elementRequired,'_',$elementRepeatable,'.png')"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="$schema != '' and $schema != 'S1000D'">
								<xsl:value-of select="$schema"/>:<xsl:value-of select="$caption"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
 									<xsl:when test="$elementOrGroup = 'element'">
 										<a href="../Elements/{$caption}.xml">
 											<xsl:value-of select="$caption"/>
 										</a>
 									</xsl:when>
 									<xsl:otherwise>
 										<xsl:value-of select="$caption"/>
 									</xsl:otherwise>
 								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:attribute name="class"><xsl:value-of select="$elementRightClass"/></xsl:attribute>
						<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/', $elementOrGroup, '_right_', $elementRightType,'_',$elementRequired,'_',$elementRepeatable,'.png')"/></xsl:attribute>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="attributeOut">
		<xsl:param name="caption" select="'?'"/>
		<xsl:param name="use"/>
		<xsl:if test="$debug = 'TRUE'">
            ATTRIBUTE OUT caption = <xsl:value-of select="$caption"/> use = <xsl:value-of select="$use"/>
			<br/>
		</xsl:if>
		<xsl:variable name="attributeRequired">
			<xsl:choose>
				<xsl:when test="$use = 'required'">mandatory</xsl:when>
				<xsl:otherwise>optional</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<table class="composition_table" cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="attribute_left">
						<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/attribute_left_', $attributeRequired, '.png')"/></xsl:attribute>
					</td>
					<td class="attribute_body">
						<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/attribute_body_', $attributeRequired, '.png')"/></xsl:attribute>
						<a href="../attributes/{$caption}.xml">
							<xsl:value-of select="$caption"/>
						</a>
					</td>
					<td class="attribute_right">
						<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/attribute_right_', $attributeRequired, '.png')"/></xsl:attribute>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="*/*" mode="tree">
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:param name="schema"/>
		<xsl:param name="level" select="1"/>
		<xsl:param name="siblingAttributesCount" select="0"/>
		<xsl:if test="$debug = 'TRUE'">
            */* TREE minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/> siblingAttributesCount <xsl:value-of select="$siblingAttributesCount"/>
			<br/>
		</xsl:if>
		<xsl:call-template name="treeElements">
			<xsl:with-param name="schema" select="$schema"/>
			<xsl:with-param name="level" select="$level"/>
			<xsl:with-param name="minOccurs" select="$minOccurs"/>
			<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
			<xsl:with-param name="siblingAttributesCount" select="$siblingAttributesCount"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="*" mode="element">
		<xsl:if test="$debug = 'TRUE'">
            * ELEMENT <br/>
		</xsl:if>

        &lt;<xsl:value-of select="name()"/>&gt;
        <xsl:if test="count(./child::*) != 0">
            -
        </xsl:if>
	</xsl:template>
	<xsl:template match="xs:element" mode="element">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            XS:ELEMENT ELEMENT minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:call-template name="elementOut">
			<xsl:with-param name="schema" select="$schema"/>
			<xsl:with-param name="level" select="$level"/>
			<xsl:with-param name="caption" select="@name"/>
			<xsl:with-param name="type" select="@type"/>
			<xsl:with-param name="mixed" select="@mixed"/>
			<xsl:with-param name="minOccurs" select="$minOccurs"/>
			<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
			<xsl:with-param name="childrenElementCount" select="count(*[not(self::xs:attribute | self::xs:attributeGroup)])"/>
			<xsl:with-param name="isGroup" select="'false'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xs:group" mode="element">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            * XS:GROUP ELEMENT = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:call-template name="elementOut">
			<xsl:with-param name="schema" select="$schema"/>
			<xsl:with-param name="level" select="$level"/>
			<xsl:with-param name="caption" select="@name"/>
			<xsl:with-param name="type" select="@type"/>
			<xsl:with-param name="mixed" select="@mixed"/>
			<xsl:with-param name="minOccurs" select="$minOccurs"/>
			<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
			<xsl:with-param name="childrenElementCount" select="count(*[not(self::xs:attribute | self::xs:attributeGroup)])"/>
			<xsl:with-param name="isGroup" select="'true'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xs:sequence" mode="element">
		<xsl:variable name="symbolFile">
			<xsl:choose>
				<xsl:when test="@minOccurs = 0">
					<xsl:value-of select="concat($graphicFolder,'/sequence_optional.png')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($graphicFolder,'/sequence.png')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<table class="composition_table" cellspacing="0" cellpadding="0">
			<tr>
				<td style="vertical-align: middle; padding-left: 54px; padding-bottom: 27px; background-repeat: no-repeat; background-position: center center;">
					<xsl:attribute name="background"><xsl:value-of select="$symbolFile"/></xsl:attribute>
					<br/>
				</td>
				<td style="vertical-align: middle;">
					<xsl:apply-templates mode="sequence"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="xs:choice" mode="element">
		<xsl:variable name="choiceRequired">
			<xsl:choose>
				<xsl:when test="@minOccurs = 0">optional</xsl:when>
				<xsl:otherwise>mandatory</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="choiceRepeatable">
			<xsl:choose>
				<xsl:when test="@maxOccurs = 'unbounded'">any</xsl:when>
				<xsl:otherwise>one</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<table class="composition_table" cellspacing="0" cellpadding="0">
			<tr>
				<td style="vertical-align: middle; padding-left: 54px; padding-bottom: 27px; background-repeat: no-repeat; background-position: center center;">
					<xsl:attribute name="background"><xsl:value-of select="concat($graphicFolder,'/choice_',$choiceRequired, '_', $choiceRepeatable,'.png')"/></xsl:attribute>
					<br/>
				</td>
				<td style="vertical-align: middle;">
					<xsl:apply-templates mode="sequence"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="xs:complexType" mode="element">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="'?'"/>
		<xsl:param name="caption" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            XS:COMPLEXTYPE ELEMENT caption = <xsl:value-of select="$caption"/> minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:if test="$caption != '?'">
			<xsl:call-template name="elementOut">
				<xsl:with-param name="schema" select="$schema"/>
				<xsl:with-param name="level" select="$level"/>
				<xsl:with-param name="caption" select="$caption"/>
				<xsl:with-param name="mixed" select="@mixed"/>
				<xsl:with-param name="minOccurs" select="$minOccurs"/>
				<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				<xsl:with-param name="childrenElementCount" select="count(*[not(self::xs:attribute | self::xs:attributeGroup)])"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xs:simpleContent" mode="element">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="'?'"/>
		<xsl:param name="caption" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            XS:COMPLEXTYPE ELEMENT caption = <xsl:value-of select="$caption"/> minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:if test="$caption != '?'">
			<xsl:call-template name="elementOut">
				<xsl:with-param name="schema" select="$schema"/>
				<xsl:with-param name="level" select="$level"/>
				<xsl:with-param name="caption" select="$caption"/>
				<xsl:with-param name="mixed" select="@mixed"/>
				<xsl:with-param name="minOccurs" select="$minOccurs"/>
				<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				<xsl:with-param name="childrenElementCount" select="count(*[not(self::xs:attribute | self::xs:attributeGroup)])"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xs:extension" mode="element">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="'?'"/>
		<xsl:param name="caption" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
			<!--<xsl:call-template name="attributeOut">
				<xsl:with-param name="schema" select="$schema"/>
				<xsl:with-param name="level" select="$level"/>
				<xsl:with-param name="caption" select="$caption"/>
				<xsl:with-param name="mixed" select="@mixed"/>
				<xsl:with-param name="minOccurs" select="$minOccurs"/>
				<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
				<xsl:with-param name="childrenElementCount" select="count(*[not(self::xs:attribute | self::xs:attributeGroup)])"/>
			</xsl:call-template>-->
			<!--<xsl:apply-templates />-->
	</xsl:template>

	<xsl:template match="xs:attribute | xs:attributeGroup">
		<xsl:value-of select="@ref"/>
		<br/>
	</xsl:template>
	<xsl:template match="*" mode="node">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="1"/>
		<xsl:param name="caption" select="'?'"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            * NODE type = <xsl:value-of select="name()"/> caption = <xsl:value-of select="$caption"/> minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:variable name="childrenAttributesCount" select="count(xs:attribute | xs:attributeGroup)"/>
		<xsl:variable name="notChildrenAttributesCount" select="count(*[not(self::xs:attribute | self::xs:attributeGroup)])"/>
		<table class="composition_table" cellspacing="0" cellpadding="0">
			<tr>
				<td tyle="vertical-align: middle;">
					<xsl:apply-templates select="." mode="element">
						<xsl:with-param name="schema" select="$schema"/>
						<xsl:with-param name="level" select="$level"/>
						<xsl:with-param name="caption" select="$caption"/>
						<xsl:with-param name="minOccurs" select="$minOccurs"/>
						<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
					</xsl:apply-templates>
				</td>
				<xsl:if test="$level &lt; $maxLevel and $childrenAttributesCount != 0 and $notChildrenAttributesCount != 0">
					<td>
						<table class="composition_table" cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<td class="branch_top">
										<br/>
									</td>
								</tr>
								<tr>
									<td class="branch_bottom">
										<br/>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</xsl:if>
				<td style="vertical-align: middle;">
					<xsl:if test="$level &lt; $maxLevel">
						<xsl:if test="count(xs:attribute | xs:attributeGroup) != 0">
							<xsl:call-template name="treeAttributes">
								<xsl:with-param name="notSiblingAttributesCount" select="$notChildrenAttributesCount"/>
							</xsl:call-template>
						</xsl:if>
						<xsl:apply-templates select="*[not(self::xs:attribute | self::xs:attributeGroup)]" mode="tree">
							<xsl:with-param name="schema" select="$schema"/>
							<xsl:with-param name="level" select="$level"/>
							<xsl:with-param name="minOccurs" select="$minOccurs"/>
							<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
							<xsl:with-param name="siblingAttributesCount" select="$childrenAttributesCount"/>
						</xsl:apply-templates>
					</xsl:if>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="treeAttributes">
		<xsl:param name="notSiblingAttributesCount" select="0"/>
		<xsl:if test="$debug = 'TRUE'">
            TREEATTRIBUTE notSiblingAttributesCount <xsl:value-of select="$notSiblingAttributesCount"/>
			<br/>
		</xsl:if>
		<table class="composition_table" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="branch_top">
					<br/>
				</td>
				<td colspan="1" rowspan="2">
					<table class="attribute_table" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td>
									<i>Attributes</i>
									<br/>
									<xsl:apply-templates select="xs:attribute | xs:attributeGroup"/>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<xsl:choose>
					<xsl:when test="$notSiblingAttributesCount = 0">
						<td class="branch_bottom">
							<br/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="branch_middle_continue">
							<br/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="treeElements">
		<xsl:param name="schema"/>
		<xsl:param name="level" select="1"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:param name="siblingAttributesCount" select="0"/>
		<xsl:if test="$debug = 'TRUE'">
            TREEELEMENTS minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/> siblingAttributesCount <xsl:value-of select="$siblingAttributesCount"/>
			<br/>
		</xsl:if>
		<table class="composition_table" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<xsl:choose>
					<xsl:when test="$siblingAttributesCount = 0 and count(./preceding-sibling::*[not(self::xs:attribute | self::xs:attributeGroup)]) = 0">
						<td class="branch_top">
							<br/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="branch_middle_tee">
							<br/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<td colspan="1" rowspan="2">
					<xsl:apply-templates select="." mode="node">
						<xsl:with-param name="schema" select="$schema"/>
						<xsl:with-param name="level" select="$level"/>
						<xsl:with-param name="minOccurs" select="$minOccurs"/>
						<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
					</xsl:apply-templates>
				</td>
			</tr>
			<tr>
				<xsl:choose>
					<xsl:when test="count(./following-sibling::*[not(self::xs:attribute | self::xs:attributeGroup)]) = 0">
						<td class="branch_bottom">
							<br/>
						</td>
					</xsl:when>
					<xsl:otherwise>
						<td class="branch_middle_continue">
							<br/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="xs:element[@ref != '']" mode="node">
		<xsl:param name="schema"/>
		<xsl:param name="level"/>
		<xsl:if test="$debug = 'TRUE'">
            XS:ELEMENT REF NODE <xsl:value-of select="@ref"/> minOccurs = <xsl:value-of select="@minOccurs"/> maxOccurs = <xsl:value-of select="@maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:variable name="refPrefix" select="substring-before(@ref,':')"/>
		<xsl:variable name="schemaRef">
			<xsl:choose>
				<xsl:when test="$refPrefix != ''">
					<xsl:value-of select="$refPrefix"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'S1000D'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="elementRef">
			<xsl:choose>
				<xsl:when test="$refPrefix != ''">
					<xsl:value-of select="substring-after(@ref,':')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@ref"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="elementApplyTemplate">
			<xsl:with-param name="schemaRef" select="$schemaRef"/>
			<xsl:with-param name="elementRef" select="$elementRef"/>
			<xsl:with-param name="schema" select="$schema"/>
			<xsl:with-param name="level" select="$level + 1"/>
			<xsl:with-param name="minOccurs" select="@minOccurs"/>
			<xsl:with-param name="maxOccurs" select="@maxOccurs"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xs:group[@ref != '']" mode="node">
		<xsl:param name="schema"/>
		<xsl:param name="level"/>
		<xsl:if test="$debug = 'TRUE'">
            XS:GROUP REF NODE <xsl:value-of select="@ref"/> minOccurs = <xsl:value-of select="@minOccurs"/> maxOccurs = <xsl:value-of select="@maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:variable name="refPrefix" select="substring-before(@ref,':')"/>
		<xsl:variable name="schemaRef">
			<xsl:choose>
				<xsl:when test="$refPrefix != ''">
					<xsl:value-of select="$refPrefix"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'S1000D'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="groupRef">
			<xsl:choose>
				<xsl:when test="$refPrefix != ''">
					<xsl:value-of select="substring-after(@ref,':')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@ref"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="groupApplyTemplate">
			<xsl:with-param name="schemaRef" select="$schemaRef"/>
			<xsl:with-param name="groupRef" select="$groupRef"/>
			<xsl:with-param name="schema" select="$schema"/>
			<xsl:with-param name="level" select="$level + 1"/>
			<xsl:with-param name="minOccurs" select="@minOccurs"/>
			<xsl:with-param name="maxOccurs" select="@maxOccurs"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xs:element[@type != '' and not(starts-with(@type,'xs:') or starts-with(@type,'dc:'))]" mode="node">
		<xsl:param name="schema"/>
		<xsl:param name="level"/>
		<xsl:param name="minOccurs"/>
		<xsl:param name="maxOccurs"/>
		<xsl:if test="$debug = 'TRUE'">
            XS:ELEMENT NOT XS NODE name = <xsl:value-of select="@name"/> type = <xsl:value-of select="@type"/> minOccurs = <xsl:value-of select="$minOccurs"/> maxOccurs = <xsl:value-of select="$maxOccurs"/> Level <xsl:value-of select="$level"/>
			<br/>
		</xsl:if>
		<xsl:variable name="elementType" select="@type"/>
		<xsl:apply-templates select="$s1000dSchemaCollection/xs:schema/xs:complexType[@name=$elementType]" mode="node">
			<xsl:with-param name="schema" select="$schema"/>
			<xsl:with-param name="level" select="$level"/>
			<xsl:with-param name="caption" select="@name"/>
			<xsl:with-param name="minOccurs" select="$minOccurs"/>
			<xsl:with-param name="maxOccurs" select="$maxOccurs"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:attribute">
		<xsl:call-template name="attributeOut">
			<xsl:with-param name="caption" select="@ref"/>
			<xsl:with-param name="use" select="@use"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xs:attributeGroup">
		<xsl:variable name="attributeGroupName" select="@ref"/>
		<xsl:apply-templates select="$s1000dSchemaCollection/xs:schema/xs:attributeGroup[@name=$attributeGroupName]/*"/>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->