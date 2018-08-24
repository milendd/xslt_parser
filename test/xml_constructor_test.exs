defmodule XmlConstructorTest do
  use ExUnit.Case

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
  end
end
