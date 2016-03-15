defmodule ConsoleGameTest do
  use ExUnit.Case
  doctest TTT
  import ExUnit.CaptureIO
  alias TTT.ConsoleGame
  alias TTT.HumanPlayer

  test "play a HVH game" do
    board_size_choice = "1"
    game_type_choice = "1"
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"
    play_again_no = "2\n"

    result = capture_io([input: "#{board_size_choice}\n#{game_type_choice}\n#{moves}\n#{play_again_no}"], fn ->
      ConsoleGame.start_game
    end)
    assert String.contains?(result, "Game Over!")
  end

  test "play a HVC game" do
    board_size_choice = "1"
    game_type_choice = "2"
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"
    play_again_no = "2\n"
    result = capture_io([input: "#{board_size_choice}\n#{game_type_choice}\n#{moves}\n#{play_again_no}"], fn ->
      ConsoleGame.start_game
    end)
    assert String.contains?(result, "Game Over!")
  end

  test "game results in a draw" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    moves = "1\n2\n3\n4\n5\n9\n6\n7\n8"
    play_again_no = "2\n"
    expected_announcement = "Game Over! The game was a draw."
    result = capture_io([input: "#{moves}\n#{play_again_no}"], fn ->
      ConsoleGame.play_game({board, players})
    end)
    assert String.contains?(result, expected_announcement)
  end

  test "game results in a win" do
    row1 = [1, 2, 3]
    row2 = [4, 5, 6]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    moves = "1\n2\n3\n4\n5\n6\n7\n8\n9"
    play_again_no = "2\n"
    expected_announcement =  "Game Over! The winner is: "
    result = capture_io([input: "#{moves}\n#{play_again_no}"], fn ->
      ConsoleGame.play_game({board, players})
    end)
    assert String.contains?(result, expected_announcement)
  end

  test "player asked if they want to play again" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    moves_game_1 = "7\n"
    replay_choice_yes = "1\n"
    board_size_choice = "1\n"
    game_type_choice = "1\n"
    moves_game_2 = "1\n2\n3\n4\n5\n6\n7\n"
    replay_choice_no = "2\n"
    result = capture_io([input: "#{moves_game_1}#{replay_choice_yes}#{board_size_choice}#{game_type_choice}#{moves_game_2}#{replay_choice_no}"], fn ->
      ConsoleGame.play_game({board, players})
    end)
    play_again_choice_expected =  "Do you want to play again?"
    assert String.contains?(result, play_again_choice_expected)
  end
end
