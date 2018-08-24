defmodule XsltParser do
  @moduledoc """
  Documentation for XsltParser.
  """

  defstruct ALLOWED_VERSIONS: ["1.0", "1.1", "2.0"]

  def transform(xml_file, xslt_file) do
    :ok = validate(xml_file, xslt_file)
  end

  defp validate(_xml_file, _xslt_file) do
    # TODO:
    :ok
  end
end
