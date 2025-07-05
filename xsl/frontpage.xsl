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

	<xsl:template match="frontpage">
		<html>
			<link rel="STYLESHEET" type="text/css" href="../xsl/Styles.css"/>
			<script language="javascript" src="../js/functions.js"/>
			<body>
				<br/><br/>
				<table width="90%">
					<tr>
					<td align="center">
					<a href="http://www.s1000d.org" target="new">
						<img src="../img/s1000d_frontpage.jpg" border="0"/>
					</a>
					</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>