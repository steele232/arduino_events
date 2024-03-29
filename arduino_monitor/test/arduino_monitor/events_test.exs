defmodule ArduinoMonitor.EventsTest do
  use ArduinoMonitor.DataCase

  alias ArduinoMonitor.Events

  describe "events" do
    alias ArduinoMonitor.Events.Event

    import ArduinoMonitor.EventsFixtures

    @invalid_attrs %{timestamp: nil, value: nil, source: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{timestamp: "some timestamp", value: "some value", source: "some source"}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.timestamp == "some timestamp"
      assert event.value == "some value"
      assert event.source == "some source"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{timestamp: "some updated timestamp", value: "some updated value", source: "some updated source"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.timestamp == "some updated timestamp"
      assert event.value == "some updated value"
      assert event.source == "some updated source"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
