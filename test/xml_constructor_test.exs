defmodule XmlConstructorTest do
  use ExUnit.Case
  require RecordHelper

  doctest XmlConstructor

  test "create simple xml-s" do
    person_empty_doc = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<person/>"
    assert person_empty_doc == XmlBuilder.doc(:person)

    person_empty = "<person></person>"
    assert person_empty == {:person, %{}, ""} |> XmlBuilder.generate()

    person_nil = "<person/>"
    assert person_nil == {:person, %{}, nil} |> XmlBuilder.generate()
    assert person_nil == {:person, nil, nil} |> XmlBuilder.generate()
    assert person_nil == {:person, nil, nil} |> XmlBuilder.generate()

    list = [:person, %{}, nil]
    assert person_nil == List.to_tuple(list) |> XmlBuilder.generate()
    assert person_empty_doc == person_nil |> XmlBuilder.doc()
    
    person_full = "<person>test</person>"
    assert person_full == {:person, %{}, List.to_string('test')} |> XmlBuilder.generate()
  end

  test "construct simple tuples for xml-s" do
    {:ok, xml} = File.read("test/samples/bib.xml")
    doc_xml = xml |> XmlParser.parse_string()

    # TODO:
    # IO.inspect(doc_xslt)
    # is_record = Record.is_record(doc_xslt, :xmlElement)
    # IO.puts(is_record);

    # result = XmlConstructor.parse_record(doc_xml) |> XmlBuilder.generate() |> XmlBuilder.doc()
    parsedRecord = XmlConstructor.parse_record(doc_xml)
    IO.inspect(parsedRecord)
    result = parsedRecord |> XmlBuilder.generate() |> XmlBuilder.doc()
    # IO.inspect(result)
  end
end
