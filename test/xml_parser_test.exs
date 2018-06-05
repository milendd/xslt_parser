defmodule XmlParserTest do
  use ExUnit.Case
  doctest XmlParser

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
    xml = "<list><item>one</item><item>two</item></list>"

    # extract
    assert ["one", "two"] == XmlParser.parse_string(xml) |> XmlParser.get("//item")
  end
end
