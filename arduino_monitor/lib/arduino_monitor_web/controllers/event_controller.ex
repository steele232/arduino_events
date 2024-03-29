defmodule ArduinoMonitorWeb.EventController do
  use ArduinoMonitorWeb, :controller

  alias ArduinoMonitor.Events
  alias ArduinoMonitor.Events.Event

  action_fallback ArduinoMonitorWeb.FallbackController

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, :index, events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Events.create_event(event_params) do

      if (String.contains?(event.packet, "Packet::NONE")) do
        ArduinoMonitorWeb.Endpoint.broadcast_from(self(), "wifi_events", "event_created", "Wifi Event created!!")
      end
      if (String.contains?(event.packet, "Packet::")) do
        ArduinoMonitorWeb.Endpoint.broadcast_from(self(), "non_wifi_events", "event_created", "LoRa Event created!!")
      end
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/events/#{event}")
      |> render(:show, event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    render(conn, :show, event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Events.get_event!(id)

    with {:ok, %Event{} = event} <- Events.update_event(event, event_params) do
      render(conn, :show, event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Events.get_event!(id)

    with {:ok, %Event{}} <- Events.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
