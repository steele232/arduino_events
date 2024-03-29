defmodule ArduinoMonitor.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :device_timestamp, :integer
      add :source, :string
      add :packet, :string
      add :rssi, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
