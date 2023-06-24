defmodule FMPTest do
  use ExUnit.Case
  doctest FMP

  test "greets the world" do
    assert FMP.hello() == :world
  end
end
