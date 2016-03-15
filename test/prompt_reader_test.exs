defmodule PromptReaderTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest TTT
  alias TTT.Console
  alias TTT.Board

  defmodule IOAssert do
    def assert_with_input(input, action_fn) do
      capture_io([input: input], fn -> action_fn.() end)
    end
  end

  test "it receives valid board size choice" do
    user_input = "1"
    expected_size = 3
    action_fn = fn -> assert Console.request_board_size() == expected_size end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives invalid board size choice" do
    invalid_choice = "a"
    valid_choice = "1"
    user_input = "#{invalid_choice}\n#{valid_choice}"
    expected_size = 3
    action_fn = fn -> assert Console.request_board_size() == expected_size end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives valid game_type choice" do
    user_input = "1"
    expected = "HVH"
    action_fn = fn -> assert Console.request_game_type() == expected end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "it receives invalid game_type choice" do
    invalid_choice = "a"
    valid_choice = "1"
    user_input = "#{invalid_choice}\n#{valid_choice}"
    expected_type = "HVH"
    action_fn = fn -> assert Console.request_game_type() == expected_type end
    IOAssert.assert_with_input(user_input, action_fn)
  end

  test "receives valid next move" do
    board = Board.empty_board()
    next_move = "5"
    action_fn = fn -> assert Console.request_next_move(board) == 5 end
    IOAssert.assert_with_input(next_move, action_fn)
  end

  test "receives invalid move" do
    board = Board.empty_board()
    moves = "0\n1"
    action_fn = fn -> assert Console.request_next_move(board) == 1 end
    IOAssert.assert_with_input(moves, action_fn)
  end

  test "valid replay game choice" do
    yes_input = "1"
    expected = 1
    action_fn = fn -> assert Console.play_again_option() == expected end
    IOAssert.assert_with_input(yes_input, action_fn)
  end

  test "invalid replay game choice" do
    yes_input = "3\n2"
    expected = 2
    action_fn = fn -> assert Console.play_again_option() == expected end
    IOAssert.assert_with_input(yes_input, action_fn)
  end

  test "keep requesting replay choice until valid" do
    input = "3\na\n0\n1\n"
    action_fn = fn -> assert Console.play_again_option() == 1 end
    IOAssert.assert_with_input(input, action_fn)
  end
end
