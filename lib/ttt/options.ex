defmodule TTT.Options do
  @board_sizes  %{
      1 => %{ 3 => "3X3" }
  }
  @game_types %{
      1 => %{ "HVH" => "Human VS Human"},
      2 => %{ "HVC" => "Human VS Computer"},
      3 => %{ "CVH" => "Computer VS Human"}
   }

  def board_size_options() do
    option_labels(@board_sizes)
  end

  def game_type_options() do
    option_labels(@game_types)
  end

  def lookup_board_size(:invalid), do: :invalid

  def lookup_board_size(index) do
    validate_option(@board_sizes, index)
    |> lookup_option(@board_sizes)
  end

  def lookup_game_type(index) do
    validate_option(@game_types, index)
    |> lookup_option(@game_types)
  end

  def lookup_option(:invalid, _), do: :invalid
  def lookup_option(choice, options_list) do
    List.first(Map.keys(options_list[choice]))
  end

  def validate_board_size_option(option) do
    validate_option(@board_sizes, option)
  end

  defp validate_option(options, option) do
    number_of_options = Enum.count(options)
    _validate_option(Integer.parse(option), number_of_options)
  end

  defp _validate_option(:error, _), do: :invalid
  defp _validate_option({x, _}, number_of_options) when x > 0 and x <= number_of_options, do: x
  defp _validate_option(_, _), do: :invalid

  defp option_labels(options) do
    options
    |> Map.values
    |> Enum.map(fn(option) -> Map.values(option) end)
    |> List.flatten
  end
end
