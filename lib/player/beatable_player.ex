defmodule TTT.Player.BeatablePlayer do
  alias TTT.Board.Board

  def next_move(board, _) do
    available_positions = Board.available_positions(board)
    index = random_index(available_positions)
    select_position(index, available_positions)
  end

  defp random_index(positions) do
    positions
    |> Enum.count
    |> random_number
    |> round
    |> zero_indexed
  end

  defp select_position(position, positions), do: Enum.at(positions, position)

  defp random_number(1), do: 1
  defp random_number(range), do: :random.uniform(range)

  defp zero_indexed(index), do: index - 1
end
