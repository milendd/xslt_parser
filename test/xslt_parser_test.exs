defmodule XsltParserTest do
  use ExUnit.Case
  require RecordHelper

  doctest XsltParser

  test "can extract simple template with array value" do
    {:ok, xml} = File.read("test/samples/bib.xml")
    {:ok, xslt} = File.read("test/samples/bib2.xslt")
    doc_xml = xml |> XmlParser.parse_string()
    doc_xslt = xslt |> XmlParser.parse_string()

    # IO.inspect(doc_xslt)
    # is_record = Record.is_record(doc_xslt, :xmlElement)
    # IO.puts(is_record);

    tag = RecordHelper.xmlElement(doc_xslt, :name)
    IO.inspect(tag)
  end
end
