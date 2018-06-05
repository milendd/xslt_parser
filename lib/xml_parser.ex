defmodule XmlParser do
  @moduledoc """
  Documentation for XmlParser.
  """

  # using erlang records
  # http://davekuhlman.org/elixir-xml-processing.html

  require Record
  xmerl_lib = "xmerl/include/xmerl.hrl"

  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: xmerl_lib))
  Record.defrecord(:xmlElement, Record.extract(:xmlElement, from_lib: xmerl_lib))
  Record.defrecord(:xmlAttribute, Record.extract(:xmlAttribute, from_lib: xmerl_lib))

  def parse_string(xml) when is_binary(xml) do
    # quiet - behave quietly and not output any information to standard output
    {document, []} = String.to_charlist(xml) |> :xmerl_scan.string(quiet: true)
    document
  end

  def get(node, path) do
    xpath(node, path) |> text
  end

  defp xpath(nil, _), do: nil

  defp xpath(node, path) do
    :xmerl_xpath.string(to_charlist(path), node)
  end

  defp text([]), do: nil
  defp text([item]), do: text(item)
  defp text(xmlElement(content: content)), do: text(content)
  defp text(xmlAttribute(value: value)), do: List.to_string(value)
  defp text(xmlText(value: value)), do: List.to_string(value)

  defp text(list) when is_list(list) do
    is_parsable = Enum.all?(list, fn x -> parsable?(x) end)

    case is_parsable do
      true -> Enum.map(list, fn x -> text(x) end)
      false -> fatal(list)
    end
  end

  defp text(term), do: fatal(term)

  defp parsable?(term) do
    Record.is_record(term, :xmlText) or Record.is_record(term, :xmlElement) or
      Record.is_record(term, :xmlAttribute)
  end

  defp fatal(term) do
    raise "Could not extract text value for xmerl node #{inspect(term)}"
  end
end
