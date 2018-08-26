defmodule XsltParser do
  @moduledoc """
  Documentation for XsltParser.
  """

  defstruct ALLOWED_VERSIONS: ["1.0", "1.1", "2.0"]

  def transform(xml_file, xslt_file) do
    {:ok, xml} = File.read(xml_file)
    record_xml = generate_record(xml)

    {:ok, xslt} = File.read(xslt_file)
    record_xslt = generate_record(xslt)

    record_xml = transform_record(record_xml, record_xslt)
    # IO.inspect(record_xml)

    result = record_xml |> XmlBuilder.generate() |> XmlBuilder.doc()
    :ok = validate(record_xml, record_xslt)
    {:ok, result}
  end

  defp transform_record(record_xml, _record_xslt) do
    # IO.inspect(record_xslt)
    # xslt_elements = elem(record_xslt, 2)
    # IO.inspect(xslt_elements)
    record_xml
  end

  defp validate(_record_xml, _record_xslt) do
    # TODO:
    :ok
  end

  defp generate_record(xml) do
    xml
    |> XmlParser.parse_string()
    |> XmlConstructor.parse_record()
  end
end
