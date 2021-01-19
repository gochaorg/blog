<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" 
xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
>
	<xsl:output method="html" /> 

 <xsl:template match="/">
 	<html>
 		<head>
	 		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 		</head>
 		<body>
   			<xsl:apply-templates/>
   		</body>
   	</html>
 </xsl:template>

 <xsl:template match="draw:frame/draw:text-box/text:p/draw:frame/draw:image">
 	<img border="2">
 		<xsl:attribute name="src">
			<xsl:value-of select="@xlink:href" />
 		</xsl:attribute>
 	</img>
 	<p>
 		<xsl:value-of select="../../../p" />
 	</p>
 </xsl:template>

 <xsl:template match="draw:image[@xlink:href]">
 	<img border="0">
 		<xsl:attribute name="src">
 			<xsl:value-of select="@xlink:href" />
 		</xsl:attribute>
 	</img> 
 </xsl:template>

 <xsl:template match="text:h[@text:outline-level='1']">
 		<h1>
	 		<xsl:apply-templates/>
 		</h1>
 </xsl:template>
  
 <xsl:template match="text:h[@text:outline-level='2']">
 		<h2>
	 		<xsl:apply-templates/>
 		</h2>
 </xsl:template>
 
 <xsl:template match="text:h[@text:outline-level='3']">
 		<h3>
	 		<xsl:apply-templates/>
 		</h3>
 </xsl:template>

 <xsl:template match="text:h[@text:outline-level='4']">
 		<h4>
	 		<xsl:apply-templates/>
 		</h4>
 </xsl:template>

 <xsl:template match="text:h[@text:outline-level='5']">
 		<h5>
	 		<xsl:apply-templates/>
 		</h5>
 </xsl:template>

 <xsl:template match="text:h[@text:outline-level='6']">
 		<h6>
	 		<xsl:apply-templates/>
 		</h6>
 </xsl:template>

 <xsl:template match="text:h[@text:outline-level='7']">
 		<h7>
	 		<xsl:apply-templates/>
 		</h7>
 </xsl:template>

 <xsl:template match="text:p">
 		<p>
	 		<xsl:apply-templates/>
 		</p>
 </xsl:template>

 <xsl:template match="text:list">
 		<ul>
 		<xsl:for-each select="text:list-item">
 			<li>
		 		<xsl:apply-templates/>
 			</li>
 		</xsl:for-each>
 		</ul>
 </xsl:template>
 
 <xsl:template match="table:table">
 	<table>
 		<xsl:apply-templates select="table:table-row" />
 	</table>
 </xsl:template>
 
 <xsl:template match="table:table-row">
 	<tr>
 		<xsl:apply-templates select="table:table-cell" />
 	</tr>
 </xsl:template>
 
 <xsl:template match="table:table-cell">
 	<td>
 		<xsl:if test="@table:number-rows-spanned">
 			<xsl:attribute name="rowspan">
 				<xsl:value-of select="@table:number-rows-spanned" />
 			</xsl:attribute>
 		</xsl:if>
 		<xsl:if test="@table:number-columns-spanned">
 			<xsl:attribute name="colspan">
 				<xsl:value-of select="@table:number-columns-spanned" />
 			</xsl:attribute>
 		</xsl:if>
 		<xsl:apply-templates />
 	</td>
 </xsl:template>

 
</xsl:stylesheet>

