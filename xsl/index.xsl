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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>ASD S1000D - Data dictionary</title>
			</head>
				
			<frameset rows="125,*" frameborder="YES" border="0" framespacing="0">				
				<frame name="search"  src="./Files/frame/header.xml" scrolling="NO" marginheight="0" />
				<frameset name="Viewer" cols="23%,*" frameborder="YES" resize="NO" border="1" framespacing="2">
					<frame name="toc" src="./Files/frame/toc.xml" scrolling="AUTO" />
					<frame name="content" src="./Files/frame/frontpage.xml" border="2" scrolling="AUTO" />
				</frameset>
			</frameset>
		</html>
	</xsl:template>
</xsl:stylesheet>
