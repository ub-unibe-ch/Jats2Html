<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                              xmlns:xlink="http://www.w3.org/1999/xlink"
                              xmlns:lang="http://www.w3.org/1999/xhtml">

<xsl:strip-space elements="*"/>
<xsl:output method="html" indent="yes"/>
  

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="/article/front/article-meta/title-group/article-title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="styles.css" media="screen" />
      </head>
      <body>
	      <xsl:call-template name="toc-div"/>
        <div style="margin-left:25%">
          <xsl:apply-templates/>
        </div>        
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="/article">
    <xsl:apply-templates>
  </xsl:apply-templates></xsl:template>
  
  
  <!-- toc -->
  <xsl:template name="heading-in-toc">
  <xsl:if test="string(label)">
    <xsl:value-of select="label"/><xsl:text>&#x00A0;</xsl:text>
    </xsl:if>
    <xsl:value-of select="title"/>
  </xsl:template>
  
  <xsl:template name="toc-div">
    <div class="w3-sidebar w3-bar-block" style="width:25%">
	<xsl:for-each select="//sec">
	  <xsl:call-template name="heading-in-toc"/><br/>
	</xsl:for-each>
  </div>
  </xsl:template>
  
  
  <!-- front -->
  
  
  <xsl:template match="/article/front">
    <h1 class="article-title">
      <xsl:value-of select="article-meta/title-group/article-title"/>
    </h1>
    <xsl:for-each select="article-meta/contrib-group/contrib">
      <span class="author-name">
        <xsl:value-of select="name/given-names"/><xsl:text>&#x00A0;</xsl:text>
        <xsl:value-of select="name/surname"/><xsl:text>&#x00A0;&#x00A0;</xsl:text>
      </span>
      <br/>
      <span class="affiliation">
        <xsl:value-of select="aff"/>
      </span>
      <br/>
      <span class="author-email">
        <a>
          <xsl:attribute name="href">
            <xsl:text>mailto:</xsl:text><xsl:value-of select="email"/>
          </xsl:attribute>
          <xsl:value-of select="email"/>
        </a>
      </span>
    </xsl:for-each>
    
    
    <div class="metadata">
      <xsl:value-of select="journal-meta/journal-title-group/journal-title"/>
      <xsl:text>&#x00A0;Jg.&#x00A0;</xsl:text>
      <xsl:value-of select="article-meta/volume"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="article-meta/pub-date/year"/>
      <xsl:text>)</xsl:text>
      <br/>
      <!--        <xsl:value-of select="journal-meta/issn"/><xsl:text>.&#x00A0;</xsl:text>-->
      <!--        <xsl:value-of select="journal-meta/publisher/publisher-loc"/>-->
      <!--         <xsl:text>:&#x00A0;</xsl:text>-->
      <!--        <xsl:value-of select="journal-meta/publisher/publisher-name"/>-->
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="article-meta/article-id"></xsl:value-of>
        </xsl:attribute>
        <xsl:value-of select="article-meta/article-id"></xsl:value-of></a>
      <br/>
      <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">CC BY 4.0 International License</a>
      <br></br>
    </div>

    <xsl:if test="string(article-meta/abstract)">
    <div class="abstract">
      <i><xsl:text>Abstract: </xsl:text></i>
      <xsl:value-of select="article-meta/abstract"/>
    </div>
    </xsl:if>
    
  </xsl:template>
  
  <!-- end front -->
  <!-- body -->
   
  
  <xsl:template match="/article/body/sec">
    <h2>
      <xsl:if test="string(label)">
      <xsl:value-of select="label"/><xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </h2>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="/article/body/sec/label"/>
  <xsl:template match="/article/body/sec/title"/>
  
  <xsl:template match="/article/body/sec/sec">
    <h3>
      <xsl:if test="string(label)">
      <xsl:value-of select="label"/><xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </h3>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="/article/body/sec/sec/label"/>
  <xsl:template match="/article/body/sec/sec/title"/>
  
  <xsl:template match="/article/body/sec/sec/sec">
    <h4>
      <xsl:if test="string(label)">
      <xsl:value-of select="label"/><xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </h4>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="/article/body/sec/sec/sec/label"/>
  <xsl:template match="/article/body/sec/sec/sec/title"/>
  
  
  <xsl:template match="//xref">
    <xsl:if test="@ref-type='bibr'">
    <a class="xref-bibr">
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@rid"></xsl:value-of>
      </xsl:attribute>
      <xsl:value-of select="."/> 
    </a>
    </xsl:if>
    <xsl:if test="@ref-type='fig'">
      <a class="xref-bibr">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@rid"></xsl:value-of>
        </xsl:attribute>
        <xsl:value-of select="."/> 
      </a>
    </xsl:if>
    <xsl:if test="@ref-type='table'">
      <a class="xref-bibr">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@rid"></xsl:value-of>
        </xsl:attribute>
        <xsl:value-of select="."/> 
      </a>
    </xsl:if>
    <xsl:if test="@ref-type='fn'">
      <sup><a class="xref-bibr">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@rid"></xsl:value-of>
        </xsl:attribute>
        <xsl:attribute name="id">
          <xsl:text>r</xsl:text>
          <xsl:value-of select="@rid"></xsl:value-of>
        </xsl:attribute>
        <xsl:value-of select="."/> 
      </a></sup>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="//named-content">
    <xsl:if test="@content-type='rtl'">
      <div>
        <xsl:attribute name="align">
          <xsl:text>right</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="dir">
          <xsl:text>rtl</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="."/> 
      </div>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="//disp-quote">
    <blockquote>
      <xsl:apply-templates/>
    </blockquote>
  </xsl:template> 

  <xsl:template match="//table-wrap">
    <div align="center" class="table-wrap">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"></xsl:value-of>
      </xsl:attribute>
      <xsl:if test="string(caption)">
        <p class="table_caption">
        <xsl:if test="string(label)">
          <xsl:value-of select="label"/><xsl:text>:&#x00A0;</xsl:text>
        </xsl:if>
        <xsl:value-of select="caption"/>
        </p>
      </xsl:if>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="//table-wrap/caption"/>
  <xsl:template match="//table-wrap/label"/>

  
  <xsl:template match="//table">
    <table>
      <xsl:attribute name="content-type"><xsl:value-of select="@content-type"></xsl:value-of></xsl:attribute>
      <xsl:apply-templates/>
    </table>
  </xsl:template>


  <xsl:template match="//thead">
    <thead>
      <xsl:apply-templates/>
    </thead>
  </xsl:template> 
  
  <xsl:template match="//tbody">
    <tbody>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template> 
  
  <xsl:template match="//tr">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template> 
  
  <xsl:template match="//th">
    <th>
      <xsl:apply-templates/>
    </th>
  </xsl:template> 
  
  <xsl:template match="//td">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template> 
  

  <xsl:template match="//fig">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="graphic/@xlink:href"></xsl:value-of>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"></xsl:value-of>
      </xsl:attribute>
    </img>
    <p class="pic_label"><xsl:value-of select="label"></xsl:value-of></p>
    <p class="pic_caption"><xsl:value-of select="caption"></xsl:value-of></p>
  </xsl:template>
  
  <xsl:template match="//ext-link">
  <a>
    <xsl:attribute name="href">
      <xsl:value-of select="@xlink:href"></xsl:value-of>
    </xsl:attribute>
    <xsl:value-of select="."></xsl:value-of>
  </a>
  </xsl:template>
  
  <xsl:template match="//italic">
  <i>
    <xsl:apply-templates/>
  </i>
  </xsl:template>
  
  <xsl:template match="//bold">
    <b>
      <xsl:apply-templates/>
    </b>
  </xsl:template>
  
  <xsl:template match="//strike">
    <del>
      <xsl:apply-templates/>
    </del>
  </xsl:template>
  
  <xsl:template match="//underline">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>
  
  <xsl:template match="//list[@list-type='order']">
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template> 
  
  <xsl:template match="//list[@list-type='bullet']">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
  
  <xsl:template match="//boxed-text">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template> 
  
  <xsl:template match="//p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template> 
 
  <xsl:template match="//list-item">
    <li>
       <xsl:apply-templates/>
    </li> 
  </xsl:template>
  
  <!-- end body -->
  <!-- back -->
  <xsl:template match="/article/front/article-meta/contrib-group/author-comment">
  <div class="author-comment">
    <xsl:apply-templates/>
  </div>
  </xsl:template>
  

  <xsl:template match="/article/back/fn-group">
    <h2><xsl:value-of select="/article/back/fn-group/title"></xsl:value-of></h2>
     <div class="author-comment">
       <xsl:value-of select="/article/front/article-meta/contrib-group/author-comment"/>
     </div>
    <ol class="fn-group">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>
  
  <xsl:template match="/article/back/fn-group/title"/>

  <xsl:template match="/article/back/fn-group/fn">
      <li class="fn">
        <xsl:attribute name="id">
          <xsl:value-of select="@id"></xsl:value-of>
        </xsl:attribute>
          <xsl:apply-templates/>
      </li>
  </xsl:template>
  
  <xsl:template match="/article/back/fn-group/fn/p[1]">
    <p>
      <a class="fn-back">
        <xsl:attribute name="href">
          <xsl:text>#r</xsl:text>
          <xsl:value-of select="../@id"></xsl:value-of>
        </xsl:attribute>&#11025;</a>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
 
  <xsl:template match="/article/back/ref-list">
    <div class="ref-list"><xsl:apply-templates/></div>
  </xsl:template>
  
  
<!--   <xsl:template match="/article/back/ref-list/ref/mixed-citation">
   <xsl:apply-templates/>
   </xsl:template>-->
  
  <xsl:template match="/article/back/ref-list/ref">
    <p><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="/article/back/ref-list/title">
    <h2><xsl:apply-templates/></h2>
  </xsl:template>
  
  <!-- end back -->
  
<!--  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>-->
  
  <xsl:template match="/article/back/fn-group/fn/@id"/>
  
</xsl:stylesheet>
