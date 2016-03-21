defmodule TTT.Negamax do
  alias TTT.Board
  alias TTT.BoardPlay
  alias TTT.BoardResult
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
        |> traverse_branch(move, acc, depth )
      end)
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

  defp traverse_branch(board, next_move, current_best, depth) do
    if current_best[:alpha] >= current_best[:beta] do
      current_best
    else
      result = negate(negamax(depth - 1, board, -current_best[:beta], -current_best[:alpha]))
      if result[:best_score] > current_best[:alpha] do
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

  defp negate(result) do
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
