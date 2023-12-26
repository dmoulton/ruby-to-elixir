#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneAppWeb.Webhook.TwilioController do
  use PhoneAppWeb, :controller

  def sms(conn, params) do
    persist_message(params)

    conn
    |> put_resp_content_type("text/xml")
    |> send_resp(200, incoming_sms_response())
  end

  defp persist_message(params) do
    message = %{
      message_sid: params["MessageSid"],
      account_sid: params["AccountSid"],
      body: params["Body"],
      from: params["From"],
      to: params["To"],
      status: params["SmsStatus"],
      direction: :incoming
    }

    PhoneApp.Conversations.create_sms_message(message)
  end

  defp incoming_sms_response do
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <Response></Response>
    """
  end
end
