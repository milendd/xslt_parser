defmodule XmlParserTest do
  use ExUnit.Case
  doctest XmlParser

  # TODO: add local-name() and namespaces
  # TODO: add more functions from xpath

  test "can extract simple node with xpath" do
    xml = "<person ref=\"1234\"><name title=\"\">pesho</name></person>"

    # extract text from element
    assert "pesho" == XmlParser.parse_string(xml) |> XmlParser.get("//person/name")

    # extract text from missing element
    assert nil == XmlParser.parse_string(xml) |> XmlParser.get("//no/path")

    # extract text from root attribute
    assert "1234" == XmlParser.parse_string(xml) |> XmlParser.get("//person/@ref")

    # extract text from attribute
    assert "" == XmlParser.parse_string(xml) |> XmlParser.get("//name/@title")
  end

  test "can extract complex nodes with xpath" do
    xml = """
    <?xml version="1.0" encoding="UTF-8"?>
    <bookstore>
        <book category="cooking">
            <title lang="en">Everyday Italian</title>
            <author>Giada De Laurentiis</author>
            <year>2005</year>
            <price>30.00</price>
        </book>

        <book category="web">
            <title lang="bg">XQuery Kick Start</title>
            <author>James McGovern</author>
            <author>Per Bothner</author>
            <author>Kurt Cagle</author>
            <author>James Linn</author>
            <author>Vaidyanathan Nagarajan</author>
            <year>2003</year>
            <price>49.99</price>
        </book>

        <book empty="yes">
        </book>

        <book category="web">
            <title lang="en">Learning XML</title>
            <author>Erik T. Ray</author>
            <year>2003</year>
            <price>39.95</price>
        </book>
    </bookstore>
    """

    # selects the first book element
    assert "Everyday Italian" ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("/bookstore/book[1]/title")

    # selects the last book element
    assert "Learning XML" ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("/bookstore/book[last()]/title")

    # selects the (last - 2) book element
    assert "XQuery Kick Start" ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("/bookstore/book[last()-2]/title")

    # selects all book elements with title element after the first book element
    assert ["XQuery Kick Start", "Learning XML"] ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("/bookstore/book[position()>1]/title")

    # TODO: selects the first book element with title element
    # assert "Everyday Italian" ==
    #          XmlParser.parse_string(xml)
    #          |> XmlParser.get("/bookstore/book[position()<2]/title")

    # selects all the attributes of title elements that have an attribute named lang
    assert ["en", "bg", "en"] ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("//title/@lang")

    # selects all the title elements that have an attribute named lang
    assert ["Everyday Italian", "XQuery Kick Start", "Learning XML"] ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("//title[@lang]")

    # selects all the title elements that have a "lang" attribute equals "en"
    assert ["Everyday Italian", "Learning XML"] ==
             XmlParser.parse_string(xml)
             |> XmlParser.get("//title[@lang='en']")

    # TODO: selects all the title elements of the books that have a price greater than 35.00
    # assert ["XQuery Kick Start", "Learning XML"] ==
    #          XmlParser.parse_string(xml)
    #          |> XmlParser.get("/bookstore/book[price>35.00]/title")
  end
end
