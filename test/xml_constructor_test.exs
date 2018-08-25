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

    person_full = "<person id=\"12345\">test</person>"
    assert person_full == {:person, %{id: 12345}, List.to_string('test')} |> XmlBuilder.generate()
  end

  test "construct simple tuples for xml-s" do
    {:ok, xml} = File.read("test/samples/bib.xml")
    doc_xml = xml |> XmlParser.parse_string()

    parsed_record = XmlConstructor.parse_record(doc_xml)
    # IO.inspect(parsed_record)

    result = parsed_record |> XmlBuilder.generate() |> XmlBuilder.doc()
    FileHelper.append("../test.txt", result)
  end
end
