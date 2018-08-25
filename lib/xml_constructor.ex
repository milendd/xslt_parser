defmodule XmlConstructor do
  @moduledoc """
  This is the XmlConstructor module
  """

  require Record
  require RecordHelper

  @doc """
  Returns elixir list with the given structure: [:atom, map, list]
  :atom represents the xml tag name
  map represents the attributes
  list represents the value, could be string or elements of the first structure

  Expects element of type Record (tuple)
  """
  def parse_record(element) do
    data = [nil, %{}, nil]

    case elem(element, 0) do
      :xmlElement -> handle_element(data, element) |> List.to_tuple()
      :xmlText -> handle_text(element)
      :xmlAttribute -> handle_attribute(element)
      _ -> nil
    end
  end

  defp handle_element(data, element) do
    fn_walk_collection = fn elm ->
      parse_record(elm)
    end

    children = RecordHelper.xmlElement(element, :content)
    child_results = children |> Enum.map(fn_walk_collection) |> Enum.filter(&(!is_nil(&1)))

    attributes =
      RecordHelper.xmlElement(element, :attributes)
      |> Enum.map(fn_walk_collection)
      |> create_map

    name = RecordHelper.xmlElement(element, :name)

    data
    |> List.replace_at(0, name)
    |> List.replace_at(1, attributes)
    |> List.replace_at(2, child_results)
  end

  defp handle_attribute(element) do
    name = RecordHelper.xmlAttribute(element, :name)
    value = RecordHelper.xmlAttribute(element, :value) |> List.to_string()

    Map.put(%{}, name, value)
  end

  defp handle_text(element) do
    text =
      get_text(element)
      |> String.replace("\r", "")
      |> String.replace("\t", "")
      |> String.replace("\n", "")

    case text do
      "" -> nil
      _ -> text
    end
  end

  defp get_text(element) do
    RecordHelper.xmlText(element, :value) |> List.to_string()
  end

  defp create_map(elements) do
    case elements do
      [] -> %{}
      _ -> elements |> Enum.reduce(fn map, acc -> Map.merge(acc, map) end)
    end
  end
end
