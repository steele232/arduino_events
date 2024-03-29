defmodule ArduinoMonitor.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ArduinoMonitor.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        source: "some source",
        timestamp: "some timestamp",
        value: "some value"
      })
      |> ArduinoMonitor.Events.create_event()

    event
  end
end
