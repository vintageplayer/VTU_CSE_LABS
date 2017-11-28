<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Student Database using XML and XSL</title>
			</head>
			<body>
				<div align="center">
					<table border="1" style="text-align: center;">
						<tr>
							<th>USN</th>
							<th>Name</th>
							<th>College</th>
							<th>Branch</th>
							<th>Year of Joining</th>
							<th>Email ID</th>
						</tr>
						<xsl:for-each select="info/student">
							<tr>
								<td><xsl:value-of select="USN" /></td>
								<td><xsl:value-of select="Name" /></td>
								<td><xsl:value-of select="noc" /></td>
								<td><xsl:value-of select="branch" /></td>
								<td><xsl:value-of select="yoj" /></td>
								<td><xsl:value-of select="email" /></td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
