defmodule TTT.Board do
  def empty_board(dimension) do
   Enum.to_list(1..dimension*dimension)
  end

  def play_move(board, move, mark) do
    List.replace_at(board, move - 1, mark)
  end

  def next_mark_to_play(board, marks) do
    get_move_count_per_mark(board, marks)
    |> mark_with_fewest_moves
  end

  def get_move_count_per_mark(board, marks) do
    Enum.map(marks, fn(mark) ->
      %{mark => Enum.count(board, fn(move) -> move == mark end)}
    end)
  end

  def mark_with_fewest_moves(move_counts_per_mark) do
    List.to_string(Map.keys(Enum.min_by(move_counts_per_mark, fn(x) -> Map.values(x) end)))
  end

  def game_over?(board, marks) do
    remaining_spaces?(board, marks)
  end

  def remaining_spaces?(board, marks) do
    sum_of_all_mark_moves(board, marks) < length board
  end

  def sum_of_all_mark_moves(board, marks) do
    get_move_count_per_mark(board, marks)
    |> total_moves_made
  end

  def total_moves_made(move_count) do
    Enum.reduce(move_count, 0, fn(mark_and_count, acc) -> acc + List.first(Map.values(mark_and_count)) end)
  end
end
