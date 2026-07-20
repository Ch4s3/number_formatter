defmodule NumberFormatter.ConfigTest do
  use ExUnit.Case

  alias NumberFormatter.Config

  test "returns defaults when nothing is configured" do
    assert Config.resolve(:does_not_exist, foo: 1) == [foo: 1]
  end

  test "application config overrides defaults" do
    Application.put_env(:number_formatter, :config_test, foo: 2)
    on_exit(fn -> Application.delete_env(:number_formatter, :config_test) end)

    resolved = Config.resolve(:config_test, foo: 1, bar: 3)
    assert Enum.sort(resolved) == [bar: 3, foo: 2]
  end
end
