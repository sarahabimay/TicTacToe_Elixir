defmodule TTT.PlayerFactory do
  @choice_to_players %{
                        "HVH" => [TTT.HumanPlayer, TTT.HumanPlayer],
                        "HVC" => [TTT.HumanPlayer, TTT.ComputerPlayer],
                        "CVH" => [TTT.ComputerPlayer, TTT.HumanPlayer]
                      }
  def select_players(choice) do
    @choice_to_players[choice]
  end
end
