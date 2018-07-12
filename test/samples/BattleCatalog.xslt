<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:ns="http://www.somewhere.org/BattleCatalog"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="
http://www.somewhere.org/BattleCatalog BattleCatalog.xsd">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>XML to HTML transformation of BattleCatalog</title>
            </head>
            <body>
                <h1>Каталог от исторически конфликти</h1>
                <table border="1">
                    <tbody>
                        <tr>
                        <h3>
                            <th id="ConflictColumn">Конфликт</th>
                            <th>Тип на конфликта</th>
                            <th>Начална дата</th>
                            <th>Местоположение</th>
                            <th>Атакуващ</th>
                            <th>Размер на атакуващата армия</th>
                            <th>Защитник</th>
                            <th>Размер на защитаващата армия</th>
                            <th>Резултат</th>
                            <th>Епоха</th>
                        </h3>
                        </tr>
                        <xsl:for-each select="/ns:BattleCatalog/ns:Battle">
                        <xsl:sort select="./ns:Era"/>
                            <tr>
                                <h6>
                                    <th>
                                        <xsl:value-of select="./ns:Name"/>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:ConflictType"/>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:StartDate"/>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:Place"/>
                                    </th>
                                    <th>
                                        <xsl:for-each select="./ns:Attackers/ns:Attacker">
                                            <xsl:value-of select="./ns:Name"/>
                                            <xsl:if test="position() != last()">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:Attackers/@TotalArmy"/>
                                    </th>
                                    <th>
                                        <xsl:for-each select="./ns:Defenders/ns:Defender">
                                            <xsl:value-of select="./ns:Name"/>
                                            <xsl:if test="position() != last()">
                                                <xsl:text>, </xsl:text>
                                            </xsl:if>
                                        </xsl:for-each>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:Defenders/@TotalArmy"/>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:Result"/>
                                    </th>
                                    <th>
                                        <xsl:value-of select="./ns:Era"/>
                                    </th>
                                </h6>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
