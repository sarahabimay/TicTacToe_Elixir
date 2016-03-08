defmodule ConsoleGameTest do
  use ExUnit.Case
  doctest TTT
  import ExUnit.CaptureIO
  alias TTT.ConsoleGame, as: ConsoleGame

  test "board_size options requested when game starts" do
    board_size_choice = "1"
    game_type_choice = "1"
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"
    board_size_request = "Board Size:\n"
    board_size_option = "[1] 3X3\n"

    result = capture_io([input: "#{board_size_choice}\n#{game_type_choice}\n#{moves}"], fn ->
      ConsoleGame.start_game
    end)
    assert String.contains?(result, board_size_request <> board_size_option)
  end

  test "game_type options requested when game starts" do
    board_size_choice = "1"
    game_type_choice = "1"
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"

    game_type_request = "Game Type:\n"
    game_type_option = "[1] Human VS Human\n"

    result = capture_io([input: "#{board_size_choice}\n#{game_type_choice}\n#{moves}"], fn ->
      ConsoleGame.start_game
    end)
    assert String.contains?(result, game_type_request <> game_type_option)
  end

  test "play first move for player X" do
    board_size = 3
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"
    next_move_request = "Player X, Please enter a valid move: "
    result = capture_io([input: "#{moves}"], fn ->
      ConsoleGame.play_game(board_size)
    end)
    assert String.contains?(result, next_move_request)
  end

  test "play two moves to draw the game" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"X"]
    row3 = [7, 8, "O"]
    board = row1 ++ row2 ++ row3
    moves = "7\n8"
    expected_announcement = "Game Over! The game was a draw."
    result = capture_io([input: "#{moves}"], fn ->
      ConsoleGame.play_game(board)
    end)
    assert String.contains?(result, expected_announcement)
  end

  test "play two moves to win the game" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X" ,"O"]
    row3 = [7, 8, 9 ]
    board = row1 ++ row2 ++ row3
    moves = "9"
    expected_announcement =  "Game Over! The winner is: "
    result = capture_io([input: "#{moves}"], fn ->
      ConsoleGame.play_game(board)
    end)
    assert String.contains?(result, expected_announcement)
  end
end
