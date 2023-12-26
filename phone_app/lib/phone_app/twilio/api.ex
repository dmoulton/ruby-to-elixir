#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Twilio.Api do
  def get_sms_message!(params, client \\ req_client()) do
    %{account_sid: account, message_sid: id} = params

    Req.get!(client, url: "/Accounts/#{account}/Messages/#{id}.json")
  end

  def send_sms_message!(params, client \\ req_client()) do
    account_sid = Keyword.fetch!(twilio_config(), :account_sid)
    %{from: from, to: to, body: body} = params
    body = %{From: from, To: to, Body: body}

    url = "/Accounts/#{account_sid}/Messages.json"
    Req.post!(client, url: url, form: body) 
  end

  defp twilio_config do
    Application.fetch_env!(:phone_app, :twilio) 
  end

  def req_client(opts \\ []) do
    config = twilio_config()
    default_base_url = Keyword.fetch!(config, :base_url)
    base_url = Keyword.get(opts, :base_url, default_base_url) 
    key_sid = Keyword.fetch!(config, :key_sid)
    key_secret = Keyword.fetch!(config, :key_secret)

    Req.new( 
      base_url: base_url,
      auth: {:basic, "#{key_sid}:#{key_secret}"}
    )
  end
end
