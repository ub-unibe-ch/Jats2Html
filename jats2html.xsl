<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:lang="http://www.w3.org/1999/xhtml">

<!-- 
 <xsl:preserve-space  elements="p"/>
 <xsl:strip-space elements="*"/>
-->

<xsl:output method="html" indent="yes"/>

<xsl:param name="stylesheet">../../../styles.css</xsl:param>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="/article/front/article-meta/title-group/article-title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="{$stylesheet}" media="screen"/>
      </head>
      <body>
          <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/article">
    <xsl:apply-templates> </xsl:apply-templates>
  </xsl:template>


  <!-- toc -->
  
  <xsl:template name="heading-in-toc">
    <a>
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:if test="string(label)">
        <xsl:value-of select="label"/>
        <xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </a>
  </xsl:template>
  
  <!-- 
    Das hier ist möglicherweise zu kompliziert.
    man es sich sparen, wenn man jeweils den Titel bei der fn-group einträgt.
    oder man baut ein prä-prozessor xsl...
  -->
  <xsl:template name="fn-group-heading-in-toc">
    <a>
      <xsl:attribute name="href">
        <xsl:text>#</xsl:text>
        <xsl:text>id-fn-group</xsl:text>
      </xsl:attribute>
      <xsl:if test="string(label)">
        <xsl:value-of select="label"/>
        <xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
       <xsl:if test="/article/@xml:lang='en'">
        <xsl:text>Notes</xsl:text>
      </xsl:if>
      <xsl:if test="/article/@xml:lang='de'">
        <xsl:text>Anmerkungen</xsl:text>
      </xsl:if>
    </a>
  </xsl:template>

  <xsl:template name="toc-div">
    <xsl:if test="string(/article/body/sec[1])">
    <div class="toc">
      <h3>
        <xsl:if test="/article/@xml:lang='en'">
          Contents
        </xsl:if>
        <xsl:if test="/article/@xml:lang='de'">
          Inhalt
        </xsl:if>
      </h3>
      <xsl:for-each select="//sec">
        <xsl:call-template name="heading-in-toc"/>
        <br/>
      </xsl:for-each>
      <xsl:for-each select="//fn-group">
        <xsl:call-template name="fn-group-heading-in-toc"/>
        <br/>
      </xsl:for-each>
      <xsl:for-each select="//ref-list">
        <xsl:call-template name="heading-in-toc"/>
        <br/>
      </xsl:for-each>
    </div>
    </xsl:if>
  </xsl:template>


  <!-- front -->


  <xsl:template match="/article/front">
    <div class="frontmatter">
    <div class="main">
    <h1 class="article-title">
      <xsl:apply-templates select="article-meta/title-group/article-title"/>
    </h1>
    <xsl:for-each select="article-meta/contrib-group/contrib">
      <span class="author-name">
        <xsl:value-of select="name/given-names"/>
        <xsl:text>&#x00A0;</xsl:text>
        <xsl:value-of select="name/surname"/>
        <xsl:text>&#x00A0;&#x00A0;</xsl:text>
      </span>
      <br/>
      <span class="affiliation">
        <xsl:value-of select="aff"/>
      </span>
      <br/>
      <span class="author-email">
        <a>
          <xsl:attribute name="href">
            <xsl:text>mailto:</xsl:text>
            <xsl:value-of select="email"/>
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
          <xsl:value-of select="article-meta/article-id"/>
        </xsl:attribute>
        <xsl:value-of select="article-meta/article-id"/>
      </a>
      <br/>
      <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">CC BY 4.0 International
        License</a>
      <br/>
    </div>
    </div>
    <div class="abstract-and-toc">
    <div class="main"><xsl:if test="string(article-meta/abstract)">
      <div class="abstract">
        <h3>
          <xsl:text>Abstract</xsl:text>
        </h3>
        <xsl:apply-templates select="article-meta/abstract"/>
      </div>
    </xsl:if></div>
    <xsl:call-template name="toc-div"/>
    </div>
    </div>
  </xsl:template>

  <!-- end front -->
  <!-- body -->

  <xsl:template match="/article/body">
    <div class="main">
    <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="/article/body/sec">
    <h2>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:if test="string(label)">
        <xsl:value-of select="label"/>
        <xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </h2>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="/article/body/sec/label"/>
  <xsl:template match="/article/body/sec/title"/>

  <xsl:template match="/article/body/sec/sec">
    <h3>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:if test="string(label)">
        <xsl:value-of select="label"/>
        <xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </h3>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="/article/body/sec/sec/label"/>
  <xsl:template match="/article/body/sec/sec/title"/>

  <xsl:template match="/article/body/sec/sec/sec">
    <h4>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:if test="string(label)">
        <xsl:value-of select="label"/>
        <xsl:text>&#x00A0;</xsl:text>
      </xsl:if>
      <xsl:value-of select="title"/>
    </h4>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="/article/body/sec/sec/sec/label"/>
  <xsl:template match="/article/body/sec/sec/sec/title"/>


  <xsl:template match="//xref">
    <xsl:if test="@ref-type = 'bibr'">
      <a class="xref-bibr">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@rid"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </a>
    </xsl:if>
    <xsl:if test="@ref-type = 'fig'">
      <a class="xref-bibr">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@rid"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </a>
    </xsl:if>
    <xsl:if test="@ref-type = 'table'">
      <a class="xref-bibr">
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
          <xsl:value-of select="@rid"/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </a>
    </xsl:if>
    <xsl:if test="@ref-type = 'fn'">
      <sup>
        <a class="xref-bibr">
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="@rid"/>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>r</xsl:text>
            <xsl:value-of select="@rid"/>
          </xsl:attribute>
          <xsl:value-of select="."/>
        </a>
      </sup>
    </xsl:if>
  </xsl:template>

  <xsl:template match="//named-content">
    <xsl:if test="@content-type = 'rtl'">
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
        <xsl:value-of select="@id"/>
      </xsl:attribute>  
     <xsl:if test="string(caption)">
        <p class="table_caption">
          <xsl:if test="string(label)">
            <xsl:value-of select="label"/>
            <xsl:text>:&#x00A0;</xsl:text>
          </xsl:if>
          <xsl:apply-templates select="caption/p/node()"/>
        </p>
      </xsl:if>
      <xsl:apply-templates select="table"/>
    </div>
  </xsl:template>
  
  <xsl:template match="//table-wrap/caption"/>
  <xsl:template match="//table-wrap/label"/>


  <xsl:template match="//table">
    <table>
      <xsl:attribute name="content-type">
        <xsl:value-of select="@content-type"/>
      </xsl:attribute>
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
        <xsl:value-of select="graphic/@xlink:href"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
    </img>
    <xsl:if test="string(caption)">
      <p class="pic_caption">
        <xsl:if test="string(label)">
          <span class="pic_caption_label"><xsl:value-of select="label"/></span>
          <xsl:text>:&#x00A0;</xsl:text>
        </xsl:if>
        <span class="pic_caption_text"><xsl:apply-templates select="caption/p/node()"/></span>
      </p>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="//ext-link">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@xlink:href"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
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

  <xsl:template match="//list[@list-type = 'order']">
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <xsl:template match="//list[@list-type = 'bullet']">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="//boxed-text">
    <div>
      <xsl:attribute name="content-type">
        <xsl:value-of select="@content-type"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <!-- Das hier wäre einfacher 
    Dafür muss man aber die Identity Transformation weiter unten aktivieren...
  <xsl:template match="boxed-text">
    <div>
      <xsl:apply-templates select="@* | node()"/>
    </div>
  </xsl:template>
  -->

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
  
  <xsl:template match="/article/back">
        <div class="main">
          <xsl:apply-templates/>
        </div>
  </xsl:template>
  
  
  <xsl:template match="/article/back/fn-group">
    <h2>
      <xsl:attribute name="id">
        <xsl:text>id-fn-group</xsl:text>
      </xsl:attribute>
      <xsl:if test="/article/@xml:lang='en'">
        Notes
      </xsl:if>
      <xsl:if test="/article/@xml:lang='de'">
        Anmerkungen
      </xsl:if>
    </h2>
    <div class="article-meta-notes">
      <xsl:apply-templates select="/article/front/notes"/>
    </div>
    <ol class="fn-group">
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <xsl:template match="/article/back/fn-group/title"/>

  <xsl:template match="/article/back/fn-group/fn">
    <li class="fn">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="/article/back/fn-group/fn/p[last()]" priority="1">
    <p>
      <xsl:apply-templates/>
      <a class="fn-back">
        <xsl:attribute name="href">
          <xsl:text>#r</xsl:text>
          <xsl:value-of select="../@id"/>
        </xsl:attribute>&#11025;</a>
    </p>
  </xsl:template>
  
  <xsl:template match="/article/back/ref-list">
    <h2>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:value-of select="/article/back/ref-list/title"/>
    </h2>
    <div class="ref-list">
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  <!--   <xsl:template match="/article/back/ref-list/ref/mixed-citation">
   <xsl:apply-templates/>
   </xsl:template>-->

  <xsl:template match="/article/back/ref-list/ref">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="/article/back/ref-list/title"/>
  
  <xsl:template match="/article/back/fn-group/fn/@id"/>

  <!-- end back -->
  
<!--  
<xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  -->

</xsl:stylesheet>
