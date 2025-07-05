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

	<xsl:template match="header">
		<html>
			<link rel="STYLESHEET" type="text/css" href="../xsl/Styles.css"/>
			<script language="javascript" src="../js/functions.js"/>
			<body style="background-color:rgb(129,190,247);">
				<table style="background-color:rgb(129,190,247);" width="100%">
					<tr>
						<td style="background-color:rgb(129,190,247);" width="150">
							<a href="http:\\www.s1000d.org">
								<img src="../img/s1000d_logo2.jpg" border="0"/>
							</a>
						</td>
						<td style="color:white;font-weight:bold;font-style:italic;width:30%" valign="bottom">
							<xsl:text></xsl:text>
						</td>
						<td style="color:white;background-color:rgb(129,190,247);font-size:12pt;text-align:right;width:30%">
							<a href="javascript:home();" style="color:white;background-color:rgb(129,190,247);">
								<xsl:text>Home</xsl:text>
							</a>
							<xsl:text>&#160; | &#160;</xsl:text>
							<!--<a href="javascript:about();" style="color:white;background-color:rgb(129,190,247);">-->
							<a href="javascript:popup('about.html')">
								<xsl:text>About</xsl:text>
							</a>
							<xsl:text>&#160; | &#160;</xsl:text>
							<!--<a href="javascript:disclaimer();" style="color:white;background-color:rgb(129,190,247);">-->
							<a href="javascript:popup('Disclaimer.html')">
								<xsl:text>Disclaimer</xsl:text>
							</a>
							<xsl:text>&#160; | &#160;</xsl:text>
							<!--<a href="javascript:knownissues();" style="color:white;background-color:rgb(129,190,247);">-->
							<a href="javascript:popup('KnownIssues.html')">
								<xsl:text>Known Issues</xsl:text>
							</a>
							<xsl:text>&#160; | &#160;</xsl:text>
							<!--<a href="javascript:contact();" style="color:white;background-color:rgb(129,190,247);">-->
							<a href="javascript:popup('Contact.html')">
								<xsl:text>Contact</xsl:text>
							</a>
							<xsl:text> &#160;&#160;&#160;</xsl:text>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>