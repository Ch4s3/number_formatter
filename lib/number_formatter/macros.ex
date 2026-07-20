defmodule NumberFormatter.Macros do
  @moduledoc false

  @doc """
  Determines whether a given value is blank or not. A value is considered blank
  if it is `" "`, `""`, or `nil`.

  ## Example

      iex> NumberFormatter.Macros.is_blank(" ")
      true

      iex> NumberFormatter.Macros.is_blank("")
      true

      iex> NumberFormatter.Macros.is_blank(nil)
      true

      iex> NumberFormatter.Macros.is_blank("hello world")
      false

      iex> NumberFormatter.Macros.is_blank(123)
      false

  This macro can also be used in guards:

      def foo(bar) when is_blank(bar), do: # ...
  """
  defmacro is_blank(value) do
    quote do
      unquote(value) in [" ", "", nil]
    end
  end
end
