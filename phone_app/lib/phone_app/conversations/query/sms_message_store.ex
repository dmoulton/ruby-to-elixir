#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Conversations.Query.SmsMessageStore do
  import Ecto.Query

  alias PhoneApp.Repo
  alias PhoneApp.Conversations.Schema.SmsMessage
  alias PhoneApp.Conversations.Query.ContactStore

  def get_sms_message!(id) do
    Repo.get!(SmsMessage, id)
  end

  def create_sms_message(params) do
    {:ok, contact} = ContactStore.upsert_contact(params)

    params
    |> Map.merge(%{contact_id: contact.id})
    |> SmsMessage.changeset()
    |> Repo.insert()
  end

  def update_sms_message(message_sid, update_params) do
    case Repo.get_by(SmsMessage, message_sid: message_sid) do
      nil ->
        {:error, :not_found}

      existing ->
        update_params
        |> SmsMessage.update_changeset(existing)
        |> Repo.update()
    end
  end

  def load_messages_with(contact) do
    from(
      m in SmsMessage,
      where: m.contact_id == ^contact.id,
      order_by: [desc: m.inserted_at],
      preload: [:contact]
    )
    |> Repo.all()
  end

  def example_load_messages_with_join(contact) do
    from(
      m in SmsMessage,
      join: c in assoc(m, :contact),
      where: m.contact_id == ^contact.id,
      order_by: [desc: m.inserted_at],
      preload: [contact: c]
    )
    |> Repo.all()
  end

  def load_message_list do
    distinct_query =
      from(
        m in SmsMessage,
        select: m.id,
        distinct: [m.contact_id],
        order_by: [desc: m.inserted_at]
      )

    from(
      m in SmsMessage,
      where: m.id in subquery(distinct_query),
      order_by: [desc: m.inserted_at],
      preload: [:contact]
    )
    |> Repo.all()
  end
end
