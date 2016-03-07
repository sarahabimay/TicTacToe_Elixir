defmodule OptionsTest do
  use ExUnit.Case
  doctest TTT
  alias TTT.Options, as: Options

  test "it has board size options" do
    board_size_options = ["3X3"]
    assert Options.board_size_options == board_size_options
  end

  test "it has game_type options" do
    game_type_options = ["Human VS Human"]
    assert Options.game_type_options == game_type_options
  end

  test "1 is a valid choice for board_size" do
    option = "1"
    expected = 1
    assert Options.validate_board_size_option(option) == expected
  end

  test "invalid choice for board_size" do
    option = "a"
    assert Options.validate_board_size_option(option) == :invalid
  end

  test "1 is a valid choice for game_type" do
    option = "1"
    expected = 1
    assert Options.validate_game_type_option(option) == expected
  end

  test "invalid choice for game_type" do
    option = "a"
    assert Options.validate_game_type_option(option) == :invalid
  end

  test "lookup 3x3 board size based on choice" do
    choice = "1"
    expected_size = 3
    assert Options.lookup_board_size(choice) == expected_size
  end

  test "lookup HVH game type based on choice" do
    choice = "1"
    expected_type = HVH
    assert Options.lookup_game_type(choice) == expected_type
  end
end
