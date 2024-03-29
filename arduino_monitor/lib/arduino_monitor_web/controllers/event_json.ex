defmodule ArduinoMonitorWeb.EventJSON do
  alias ArduinoMonitor.Events.Event

  @doc """
  Renders a list of events.
  """
  def index(%{events: events}) do
    %{data: for(event <- events, do: data(event))}
  end

  @doc """
  Renders a single event.
  """
  def show(%{event: event}) do
    %{data: data(event)}
  end

  defp data(%Event{} = event) do
    %{
      id: event.id,
      device_timestamp: event.device_timestamp,
      source: event.source,
      packet: event.packet,
      rssi: event.rssi
    }
  end
end
