defmodule PlayerFactoryTest do
  use ExUnit.Case
  doctest TTT

  test "get two Human Players" do
    choice = "HVH"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.HumanPlayer, TTT.HumanPlayer]
  end

  test "get player1 as Computer and player2 as HumanPlayer" do
    choice = "CVH"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.ComputerPlayer, TTT.HumanPlayer]
  end

  test "get player1 as HumanPlayer and player2 as ComputerPlayer" do
    choice = "HVC"
    assert TTT.PlayerFactory.select_players(choice) == [TTT.HumanPlayer, TTT.ComputerPlayer]
  end
end
