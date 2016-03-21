defmodule TTT.PlayerFactory do
  @choice_to_players %{
                        "HVH" => [TTT.HumanPlayer, TTT.HumanPlayer],
                        "HVB" => [TTT.HumanPlayer, TTT.BeatablePlayer],
                        "BVH" => [TTT.BeatablePlayer, TTT.HumanPlayer],
                        "HVU" => [TTT.HumanPlayer, TTT.UnbeatablePlayer],
                        "UVH" => [TTT.UnbeatablePlayer, TTT.HumanPlayer]
                      }
  def select_players(choice) do
    @choice_to_players[choice]
  end
end
