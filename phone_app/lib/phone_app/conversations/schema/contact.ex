#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Conversations.Schema.Contact do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime_usec]
  schema "contacts" do
    has_many :sms_messages, PhoneApp.Conversations.Schema.SmsMessage

    field :phone_number, :string
    field :name, :string

    timestamps()
  end

  import Ecto.Changeset

  def changeset(attrs) do
    fields = [:phone_number]

    %__MODULE__{}
    |> cast(attrs, fields)
    |> validate_required(fields)
    |> unique_constraint([:phone_number])
  end
end
