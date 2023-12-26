#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Repo.Migrations.CreateSmsMessages do
  use Ecto.Migration

  def change do
    create table(:sms_messages) do
      add :contact_id, :integer, null: false

      add :message_sid, :text, null: false
      add :account_sid, :text, null: false

      add :body, :text, null: false
      add :from, :text, null: false
      add :to, :text, null: false

      add :status, :text, null: false
      add :direction, :text, null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:sms_messages, [:contact_id])
    create unique_index(:sms_messages, [:message_sid])
  end
end
