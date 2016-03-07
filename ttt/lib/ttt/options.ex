defmodule TTT.Options do
  @board_sizes  %{3 => "3X3"}
  @game_types %{HVH => "Human VS Human"}

  def board_size_options do
    Map.values(@board_sizes)
  end

  def game_type_options do
    Map.values(@game_types)
  end

  def validate_board_size_option(option) do
    validate_option(@board_sizes, option)
  end

  def validate_game_type_option(option) do
    validate_option(@game_types, option)
  end

  def validate_option(options, option) do
    number_of_options = Enum.count(options)
    case Integer.parse(option) do
      {x, _} when x > 0 and x <= number_of_options -> option
      :error -> :invalid
      _ -> :invalid
    end
  end
end
