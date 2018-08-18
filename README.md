# XsltParser

**Elixir library for native transform xml using xslt**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `xslt_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:xslt_parser, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/xslt_parser](https://hexdocs.pm/xslt_parser).

## Usage
Easy transform XML using XSLT 2.0(or 1.0) stylesheet
```
{:ok, xml} = XsltParser.transform('bib.xml', 'bib.xslt')
```

Or create file with the transformed XML
```
XsltParser.transform('bib.xml', 'bib.xslt', 'bib_result.xml')
```
