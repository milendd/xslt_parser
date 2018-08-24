defmodule FileHelper do
  @moduledoc """
  Documentation for FileHelper.
  """

  def append_line(filename, results) do
    append(filename, results, :newline)
  end

  def append(filename, result) do
    append(filename, result, nil)
  end

  defp append(filename, results, options) when is_list(results) do
    {:ok, file} = File.open(filename, [:append])
    save_results(file, results, options)
    File.close(file)
  end

  defp append(filename, element, options) do
    append(filename, [element], options)
  end

  defp save_results(_file, [], :newline), do: :ok

  defp save_results(file, [data | rest], :newline) do
    IO.binwrite(file, data)
    IO.binwrite(file, "\n")
    save_results(file, rest, :newline)
  end

  defp save_results(_file, [], _), do: :ok

  defp save_results(file, [data | rest], options) do
    IO.binwrite(file, data)
    save_results(file, rest, options)
  end
end
