defmodule PlayerFactoryTest do
  use ExUnit.Case
  alias TTT.Player.BeatablePlayer
  alias TTT.Player.HumanPlayer
  alias TTT.Player.UnbeatablePlayer
  alias TTT.Player.PlayerFactory

  test "get two Human Players" do
    choice = "HVH"
    assert PlayerFactory.select_players(choice) == [HumanPlayer, HumanPlayer]
  end

  test "get player1 as Beatable player and player2 as HumanPlayer" do
    choice = "BVH"
    assert PlayerFactory.select_players(choice) == [BeatablePlayer, HumanPlayer]
  end

  test "get player1 as HumanPlayer and player2 as BeatablePlayer" do
    choice = "HVB"
    assert PlayerFactory.select_players(choice) == [HumanPlayer, BeatablePlayer]
  end

  test "get player1 as HumanPlayer and player2 as UnbeatablePlayer" do
    choice = "HVU"
    assert PlayerFactory.select_players(choice) == [HumanPlayer, UnbeatablePlayer]
  end

  test "get player1 as UnbeatablePlayer and player2 as HumanPlayer" do
    choice = "UVH"
    assert PlayerFactory.select_players(choice) == [UnbeatablePlayer, HumanPlayer]
  end
end
