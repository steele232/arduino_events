defmodule ArduinoMonitorWeb.EventsLive do
  use ArduinoMonitorWeb, :live_view

  alias ArduinoMonitor.Events
  @topic "non_wifi_events"
  @default_locale "en"
  @default_timezone "UTC"
  @default_timezone_offset 0

  def mount(_params, _session, socket) do
    ArduinoMonitorWeb.Endpoint.subscribe(@topic)
    eventsList = fetchLatestNonWifiEvents()
    socket =
      socket
      |> assign_locale()
      |> assign_timezone()
      |> assign_timezone_offset()
    {:ok,
     assign(socket,
      time_since_last_wifi_msg: 100,
      time_since_last_lora_msg: 120,
      last_rssi_value: 47,
      events: eventsList
     )}
  end

  defp assign_locale(socket) do
    locale = get_connect_params(socket)["locale"] || @default_locale
    locale |> IO.inspect(label: "Locale assigned is ")
    assign(socket, locale: locale)
  end

  defp assign_timezone(socket) do
    timezone = get_connect_params(socket)["timezone"] || @default_timezone
    timezone |> IO.inspect(label: "Timezone assigned is ")
    assign(socket, timezone: timezone)
  end

  defp assign_timezone_offset(socket) do
    timezone_offset = get_connect_params(socket)["timezone_offset"] || @default_timezone_offset
    assign(socket, timezone_offset: timezone_offset)
  end

  def handle_info(msg, socket) do
    IO.inspect(msg, label: "Message came in")
    eventsList = fetchLatestNonWifiEvents()
    {:noreply, assign(socket, events: eventsList)}
  end

  defp fetchLatestNonWifiEvents() do
    eventsList = Events.list_latest_nonwifi_events()
    eventsList |> Enum.map(fn ev -> Map.update!(ev, :packet, fn pk -> String.split(pk, "::") |> List.last() end) end)
  end

end
