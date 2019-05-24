defmodule Newsfun.ScoreAdjuster do
  use GenServer
  alias Newsfun.ArticleFetcherService, as: AFS

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    AFS.time_based_score_adjust(6)
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, how_many_minutes(6))
  end

  defp how_many_minutes(minutes) do
    minutes * 1000 * 60
  end
end
