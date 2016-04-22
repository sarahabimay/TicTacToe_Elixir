defmodule OptionsTest do
  use ExUnit.Case
  alias TTT.Options

  test "it has board size options" do
    board_size_options = ["3X3", "4X4"]
    assert Options.board_size_options == board_size_options
  end

  test "it has all game_type options" do
    game_type_options = [
                          "Human VS Human",
                          "Human VS Beatable",
                          "Beatable VS Human",
                          "Human VS Unbeatable",
                          "Unbeatable VS Human",
    ]
    assert Options.game_type_options == game_type_options
  end

  test "3X3 board size chosen" do
    choice = "1"
    expected_size = 3
    assert Options.lookup_board_size(choice) == expected_size
  end

  test "4X4 board size chosen" do
    choice = "2"
    expected_size = 4
    assert Options.lookup_board_size(choice) == expected_size
  end

  test "invalid board_size chosen" do
    option = "a"
    assert Options.lookup_game_type(option) == :invalid
  end

  test "valid HVH game_type chosen" do
    option = "1"
    expected = "HVH"
    assert Options.lookup_game_type(option) == expected
  end

  test "invalid game_type chosen" do
    option = "a"
    assert Options.lookup_game_type(option) == :invalid
  end

  test "valid HVB game_type chosen" do
    choice = "2"
    expected_type = "HVB"
    assert Options.lookup_game_type(choice) == expected_type
  end

  test "valid BVH game_type chosen" do
    choice = "3"
    expected_type = "BVH"
    assert Options.lookup_game_type(choice) == expected_type
  end

  test "valid HVU game_type chosen" do
    choice = "4"
    expected_type = "HVU"
    assert Options.lookup_game_type(choice) == expected_type
  end

  test "valid UVH game_type chosen" do
    choice = "5"
    expected_type = "UVH"
    assert Options.lookup_game_type(choice) == expected_type
  end
end
