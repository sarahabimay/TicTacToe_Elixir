defmodule PlayerFactoryTest do
  use ExUnit.Case
  doctest TTT

  test "get two Human Players" do
    choice = "HVH"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.HumanPlayer, TTT.HumanPlayer]
  end

  test "get player1 as Beatable player and player2 as HumanPlayer" do
    choice = "BVH"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.BeatablePlayer, TTT.HumanPlayer]
  end

  test "get player1 as HumanPlayer and player2 as BeatablePlayer" do
    choice = "HVB"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.HumanPlayer, TTT.BeatablePlayer]
  end

  test "get player1 as HumanPlayer and player2 as UnbeatablePlayer" do
    choice = "HVU"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.HumanPlayer, TTT.UnbeatablePlayer]
  end

  test "get player1 as UnbeatablePlayer and player2 as HumanPlayer" do
    choice = "UVH"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.UnbeatablePlayer, TTT.HumanPlayer]
  end
end
