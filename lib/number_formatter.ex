defmodule NumberFormatter do
  @moduledoc """
  `NumberFormatter` provides functions to convert numbers into a variety of different
  formats. Ultimately, it aims to be a partial clone of
  [ActionView::Helpers::NumberHelper](http://api.rubyonrails.org/classes/ActionView/Helpers/NumberHelper.html)
  from Rails.

  If you want to import all of the functions provided by `NumberFormatter`, simply `use`
  it in your module:

      defmodule MyModule do
        use NumberFormatter
      end

  More likely, you'll want to import the functions you want from one of
  `NumberFormatter`'s submodules.

      defmodule MyModule do
        import NumberFormatter.Currency
      end

  ## Configuration

  Some of `NumberFormatter`'s behavior can be configured through Mix. Each submodule
  contains documentation on how to configure it.
  """

  @type t :: number | Decimal.t()

  @doc false
  defmacro __using__(_) do
    quote do
      import NumberFormatter.Currency
      import NumberFormatter.Delimit
      import NumberFormatter.Phone
      import NumberFormatter.Percentage
      import NumberFormatter.Human
    end
  end
end
