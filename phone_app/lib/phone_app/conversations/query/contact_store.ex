#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Conversations.Query.ContactStore do
  alias PhoneApp.Repo
  alias PhoneApp.Conversations.Schema.Contact

  def get_contact!(id) do
    Repo.get!(Contact, id)
  end

  def upsert_contact(%{from: from, to: to, direction: direction}) do
    contact_number =
      case direction do
        :incoming -> from
        :outgoing -> to
      end

    cs = Contact.changeset(%{phone_number: contact_number})

    Repo.insert(
      cs,
      on_conflict: {:replace, [:updated_at]},
      conflict_target: [:phone_number]
    )
  end
end
