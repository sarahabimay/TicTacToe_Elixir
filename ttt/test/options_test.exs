defmodule OptionsTest do
  use ExUnit.Case
  doctest TTT

  test "it has board size options" do
    board_size_options = ["3X3"]
    assert TTT.Options.board_size_options == board_size_options
  end

  test "it has game_type options" do
    game_type_options = ["Human VS Human"]
    assert TTT.Options.game_type_options == game_type_options
  end

  test "1 is a valid choice for board_size" do
    option = "1"
    assert TTT.Options.validate_board_size_option(option) == option
  end

  test "invalid choice for board_size" do
    option = "a"
    assert TTT.Options.validate_board_size_option(option) == :invalid
  end

  test "1 is a valid choice for game_type" do
    option = "1"
    assert TTT.Options.validate_game_type_option(option) == option
  end

  test "invalid choice for game_type" do
    option = "a"
    assert TTT.Options.validate_game_type_option(option) == :invalid
  end
end
