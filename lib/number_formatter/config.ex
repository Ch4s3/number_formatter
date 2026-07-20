defmodule NumberFormatter.Config do
  @moduledoc false

  @doc """
  Merges `defaults` with whatever's set for `key` under the
  `:number_formatter` application config, config values taking precedence.
  """
  @spec resolve(atom, Keyword.t()) :: Keyword.t()
  def resolve(key, defaults) do
    Keyword.merge(defaults, Application.get_env(:number_formatter, key, []))
  end
end
