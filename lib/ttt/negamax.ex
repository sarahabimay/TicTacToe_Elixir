defmodule TTT.Negamax do
  alias TTT.Board.Board
  alias TTT.Board.BoardPlay
  alias TTT.Board.BoardResult
  @initial_score 10.0
  @initial_move -1

  def negamax(depth, current_board, alpha, beta) do
    if BoardResult.game_over?(current_board) || depth == 0 do
      %{:best_score => score(current_board), :best_move => @initial_move}
    else
      current_board
      |> Board.available_positions
      |> Enum.reduce(result_accumulator(alpha, beta), fn(move, acc) ->
        move
        |> BoardPlay.play_move(current_board)
        |> traverse_branch(move, acc, depth)
      end)
    end
  end

  defp traverse_branch(board, next_move, current_best, depth) do
    if prunable?(current_best) do
      current_best
    else
      result = negate_score(negamax(depth - 1, board, -current_best[:beta], -current_best[:alpha]))
      if found_better_score?(result, current_best) do
        %{
          :best_score => result[:best_score] ,
          :best_move => next_move,
          :alpha => result[:best_score],
          :beta => current_best[:beta],
        }
      else
        current_best
      end
    end
  end

  defp result_accumulator(alpha, beta) do
    %{
      :best_score => -@initial_score,
      :best_move => @initial_move,
      :alpha => alpha,
      :beta => beta,
    }
  end

  defp found_better_score?(new_score, old_score) do
    new_score[:best_score] > old_score[:alpha]
  end

  defp prunable?(current_best) do
    current_best[:alpha] >= current_best[:beta]
  end

  defp negate_score(result) do
    %{:best_score => -result[:best_score], :best_move => result[:best_move]}
  end

  defp score(board) do
    if BoardResult.found_winner?(board) do
      -(@initial_score / spaces_occupied(board))
    else
      0
    end
  end

  defp spaces_occupied(board) do
    Enum.count(board) - Enum.count(Board.available_positions(board))
  end
end
