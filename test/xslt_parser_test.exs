defmodule XsltParserTest do
  use ExUnit.Case
  require RecordHelper

  doctest XsltParser

  test "can extract tag names from xslt and xml" do
    {:ok, xml} = File.read("test/samples/bib.xml")
    {:ok, xslt} = File.read("test/samples/bib2.xslt")
    doc_xml = xml |> XmlParser.parse_string()
    doc_xslt = xslt |> XmlParser.parse_string()

    xslt_tag = RecordHelper.xmlElement(doc_xslt, :name)
    assert xslt_tag == String.to_atom("xsl:stylesheet")

    xml_tag = RecordHelper.xmlElement(doc_xml, :name)
    assert xml_tag == String.to_atom("bib")
  end

  test "can transform simple xslt and xml" do
    XsltParser.transform("test/samples/bib.xml", "test/samples/bib2.xslt")
    # |> IO.inspect()
  end
end
