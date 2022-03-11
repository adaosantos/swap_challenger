defmodule SwapTest do
  use ExUnit.Case
  doctest Swap

  test "greets the world" do
    assert Swap.hello() == :world
  end
end
