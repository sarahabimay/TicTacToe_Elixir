defmodule ConsoleGameTest do
  use ExUnit.Case
  doctest TTT
  import ExUnit.CaptureIO
  alias TTT.ConsoleGame, as: ConsoleGame

  test "play a HVH game" do
    board_size_choice = "1"
    game_type_choice = "1"
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"

    result = capture_io([input: "#{board_size_choice}\n#{game_type_choice}\n#{moves}"], fn ->
      ConsoleGame.start_game
    end)
    assert String.contains?(result, "Game Over!")
  end

  test "game results in a draw" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"
    expected_announcement = "Game Over! The game was a draw."
    result = capture_io([input: "#{moves}"], fn ->
      ConsoleGame.play_game(board)
    end)
    assert String.contains?(result, expected_announcement)
  end

  test "game results in a win" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    moves = "1\n2\n3\n4\n5\n6\n7\n8\n9"
    expected_announcement =  "Game Over! The winner is: "
    result = capture_io([input: "#{moves}"], fn ->
      ConsoleGame.play_game(board)
    end)
    assert String.contains?(result, expected_announcement)
  end
end
