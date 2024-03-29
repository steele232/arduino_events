defmodule ArduinoMonitor.Repo do
  use Ecto.Repo,
    otp_app: :arduino_monitor,
    adapter: Ecto.Adapters.SQLite3
end
