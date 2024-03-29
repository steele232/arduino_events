defmodule ArduinoMonitor.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :device_timestamp, :integer
    field :rssi, :integer
    field :packet, :string
    field :source, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:device_timestamp, :source, :packet, :rssi])
    |> validate_required([:device_timestamp, :source, :packet, :rssi])
  end
end
