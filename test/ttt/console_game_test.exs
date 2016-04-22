defmodule ConsoleGameTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias TTT.Board.Board
  alias TTT.Console.Console
  alias TTT.ConsoleGame
  alias TTT.Player.HumanPlayer
  alias TTT.Player.BeatablePlayer

  defmodule FakeDisplay do
    def display_board(_) do
      send self(), "board displayed"
    end

    def request_options(), do: [3, "HVH"]

    def request_board_size(), do: 3

    def request_game_type(), do: "HVH"

    def request_next_move(_), do: 7

    def play_again_option() do
      send self(), "Play Again: No"
      2
    end

    def announce_result(false, _) do
      send self(), "Game Over! The game was a draw."
    end

    def announce_result(true, _) do
      send self(), "Game Over! The winner is: "
    end

    def closing_down_message() do
      send self(), "Goodbye"
    end

    def clear_screen() do
      send self(), "Screen Cleared"
    end
  end

  test "play a HVH game" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    ConsoleGame.play_game({board, FakeDisplay, players})
    assert_received "Goodbye"
  end

  test "play a HVC game" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [BeatablePlayer, HumanPlayer]
    ConsoleGame.play_game({board, FakeDisplay, players})
    assert_received "Goodbye"
  end

  test "game results in a draw" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "X"]
    row3 = [7, "X", "O"]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    ConsoleGame.play_game({board, FakeDisplay, players})
    assert_received  "Game Over! The game was a draw."
  end

  test "game results in a win" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    ConsoleGame.play_game({board, FakeDisplay, players})
    assert_received  "Game Over! The winner is: "
  end

  test "play again is yes" do
    board_size_choice = "1\n"
    game_type_choice = "1\n"
    moves = "1\n2\n3\n4\n5\n6\n7\n"
    play_again_yes = "1\n"
    play_again_no = "2\n"
    expected_announcement = "Game Over!"
    input =
    board_size_choice <>
    game_type_choice <>
    moves <>
    play_again_yes <>
    board_size_choice <>
    game_type_choice <>
    moves <>
    play_again_no

    result = capture_io([input: input], fn -> ConsoleGame.start_game(Board, Console) end)
    assert String.contains?(result, expected_announcement)
  end
end
