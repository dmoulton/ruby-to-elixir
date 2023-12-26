#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Conversations.Worker.StatusWorker do
  use Oban.Worker

  alias PhoneApp.Conversations.Schema.SmsMessage

  def enqueue(%SmsMessage{} = message) do
    %{id: message.id}
    |> new()
    |> Oban.insert()
  end

  alias PhoneApp.Conversations.Query.SmsMessageStore

  def perform(%Oban.Job{args: %{"id" => message_id}}) do
    message = SmsMessageStore.get_sms_message!(message_id)
    %{body: resp} = PhoneApp.Twilio.get_sms_message!(message)

    case resp["status"] do
      "queued" ->
        {:error, "Message not ready"}

      status ->
        PhoneApp.Conversations.update_sms_message(
          message.message_sid,
          %{status: status}
        )
    end
  end
end
