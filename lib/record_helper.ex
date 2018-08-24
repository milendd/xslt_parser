defmodule RecordHelper do
  @moduledoc """
  Documentation for RecordHelper.
  """

  # using erlang records
  # http://davekuhlman.org/elixir-xml-processing.html

  require Record

  xmerl_lib = "xmerl/include/xmerl.hrl"
  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: xmerl_lib))
  Record.defrecord(:xmlElement, Record.extract(:xmlElement, from_lib: xmerl_lib))
  Record.defrecord(:xmlAttribute, Record.extract(:xmlAttribute, from_lib: xmerl_lib))
end
