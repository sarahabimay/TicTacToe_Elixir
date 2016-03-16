defmodule ConsoleGameTest do
  use ExUnit.Case
  doctest TTT
  import ExUnit.CaptureIO
  alias TTT.ConsoleGame
  alias TTT.HumanPlayer
  alias TTT.ComputerPlayer

  defmodule FakeDisplay do
    require Logger
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
    ConsoleGame.start_game(board, FakeDisplay)
    assert_received "Goodbye"
  end

  test "play a HVC game" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [ComputerPlayer, HumanPlayer]
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

  test "player asked if they want to play again" do
    row1 = ["X", "O", "X"]
    row2 = ["O", "X", "O"]
    row3 = [7, 8, 9]
    board = row1 ++ row2 ++ row3
    players = [HumanPlayer, HumanPlayer]
    ConsoleGame.play_game({board, FakeDisplay, players})
    assert_received "Play Again: No"
  end

  test "entire HVH game" do
    game_type_choice = "1"
    moves = "1\n2\n3\n4\n5\n6\n7"
    play_again_no = "2"
    expected_announcement =  "Game Over!"
    result = capture_io([input: "#{game_type_choice}\n#{moves}\n#{play_again_no}\n"], fn ->
      ConsoleGame.start_game(TTT.Board.empty_board(), TTT.Console)
    end)
    assert String.contains?(result, expected_announcement)
  end
end
