#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Twilio do
  defdelegate send_sms_message!(msg), to: PhoneApp.Twilio.Api
  defdelegate get_sms_message!(msg), to: PhoneApp.Twilio.Api
end
