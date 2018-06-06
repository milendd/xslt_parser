defmodule XmlParserTest do
  use ExUnit.Case
  doctest XmlParser

  # TODO: add local-name() and namespaces
  # TODO: add more functions from xpath
  # TODO: add wildcards

  test "can extract simple node with xpath" do
    simple_xml = "<person ref=\"1234\"><name title=\"\">pesho</name></person>"

    # extract text from element
    assert "pesho" == XmlParser.parse_string(simple_xml) |> XmlParser.get("//person/name")

    # extract text from missing element
    assert nil == XmlParser.parse_string(simple_xml) |> XmlParser.get("//no/path")

    # extract text from root attribute
    assert "1234" == XmlParser.parse_string(simple_xml) |> XmlParser.get("//person/@ref")

    # extract text from attribute
    assert "" == XmlParser.parse_string(simple_xml) |> XmlParser.get("//name/@title")
  end

  test "can extract complex nodes with xpath" do
    doc = XmlTestContainer.get_books_xml() |> XmlParser.parse_string()

    # selects the first book element
    result = XmlParser.get(doc, "/bookstore/book[1]/title")
    assert "Everyday Italian" == result

    # selects the last book element
    result = XmlParser.get(doc, "/bookstore/book[last()]/title")
    assert "Learning XML" == result

    # selects the (last - 2) book element
    result = XmlParser.get(doc, "/bookstore/book[last()-2]/title")
    assert "XQuery Kick Start" == result

    # selects all the attributes of title elements that have an attribute named lang
    result = XmlParser.get(doc, "//title/@lang")
    assert ["en", "bg", "en"] == result

    # selects all the title elements that have an attribute named lang
    result = XmlParser.get(doc, "//title[@lang]")
    assert ["Everyday Italian", "XQuery Kick Start", "Learning XML"] == result

    # selects all the title elements that have a "lang" attribute equals "en"
    result = XmlParser.get(doc, "//title[@lang='en']")
    assert ["Everyday Italian", "Learning XML"] == result

    # TODO: selects all the title elements of the books that have a price greater than 35.00
    # result = XmlParser.get(doc, "/bookstore/book[price>35.00]/title")
    # assert ["XQuery Kick Start", "Learning XML"] == result
  end

  test "can use position() with '=' operator in xpath" do
    doc = XmlTestContainer.get_books_xml() |> XmlParser.parse_string()

    # selects nil from book elements, because position starts from 1
    result = XmlParser.get(doc, "/bookstore/book[position()=0]")
    assert nil == result

    result = XmlParser.get(doc, "/bookstore/book[position()=1]/title")
    assert "Everyday Italian" == result

    result = XmlParser.get(doc, "/bookstore/book[position()=2]/title")
    assert "XQuery Kick Start" == result

    result = XmlParser.get(doc, "/bookstore/book[position()=3]/title")
    assert nil == result

    result = XmlParser.get(doc, "/bookstore/book[position()=4]/title")
    assert "Learning XML" == result

    result = XmlParser.get(doc, "/bookstore/book[position()=last()]/title")
    assert "Learning XML" == result

    result = XmlParser.get(doc, "/bookstore/book[position()=last()-2]/title")
    assert "XQuery Kick Start" == result
  end

  test "can use position() with '>' greater operator" do
    doc = XmlTestContainer.get_books_xml() |> XmlParser.parse_string()

    result = XmlParser.get(doc, "/bookstore/book[position()>0]/title")
    assert ["Everyday Italian", "XQuery Kick Start", "Learning XML"] == result

    result = XmlParser.get(doc, "/bookstore/book[position()>1]/title")
    assert ["XQuery Kick Start", "Learning XML"] == result

    result = XmlParser.get(doc, "/bookstore/book[position()>2]/title")
    assert "Learning XML" == result

    result = XmlParser.get(doc, "/bookstore/book[position()>3]/title")
    assert "Learning XML" == result

    result = XmlParser.get(doc, "/bookstore/book[position()>4]/title")
    assert nil == result
  end

  test "can use position() with '<' less operator" do
    # doc = XmlTestContainer.get_books_xml() |> XmlParser.parse_string()

    # TODO:
    # result = XmlParser.get(doc, "/bookstore/book[position()<1]/title")
    # assert nil == result

    # TODO:
    # result = XmlParser.get(doc, "/bookstore/book[position()<2]/title")
    # assert "Everyday Italian" == result

    # TODO:
    # result = XmlParser.get(doc, "/bookstore/book[position()<3]/title")
    # assert ["Everyday Italian", "XQuery Kick Start"] == result

    # TODO:
    # result = XmlParser.get(doc, "/bookstore/book[position()<5]/title")
    # assert ["Everyday Italian", "XQuery Kick Start", "Learning XML"] == result
  end
end
