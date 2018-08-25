defmodule XmlConstructor do
  @moduledoc """
  Documentation for XmlConstructor.
  """

  require Record
  require RecordHelper

  def parse_record(element) do
    data = [nil, %{}, nil]

    case elem(element, 0) do
      :xmlElement -> handle_element(data, element) |> List.to_tuple
      :xmlText -> handle_text(data, element)
      :xmlAttribute -> List.to_tuple(data) # IO.inspect("io: attr") # handle_attribute(node)
      _ -> List.to_tuple(data) # handle_the_others(node)
    end
  end
  
  defp handle_element(data, element) do
    fn_walk_children = fn (elm) ->
      parse_record(elm)
    end

    children = RecordHelper.xmlElement(element, :content)
    child_results = Enum.map(children, fn_walk_children) |> Enum.filter(& !is_nil(&1))

    name = RecordHelper.xmlElement(element, :name)
    data |> List.replace_at(0, name) |> List.replace_at(2, child_results)
  end

  defp handle_text(data, element) do
    text = get_text(element) 
      |> String.replace("\r", "")
      |> String.replace("\t", "")
      |> String.replace("\n", "")
    
    case text do
      "" -> nil
      _ -> text
    end
  end

  defp get_text(element) do
    RecordHelper.xmlText(element, :value) |> List.to_string
  end

  # TODO: remove
  # defp get_name(element) do
  #   case elem(element, 0) do
  #     :xmlElement -> RecordHelper.xmlElement(element, :name)
  #     :xmlText -> RecordHelper.xmlText(element, :value) |> List.to_string
  #     :xmlAttribute -> nil # RecordHelper.xmlAttribute(element, :value) |> List.to_string
  #     _ -> nil
  #   end
  # end
end
