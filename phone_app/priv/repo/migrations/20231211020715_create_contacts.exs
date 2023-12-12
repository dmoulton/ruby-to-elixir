#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneApp.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :phone_number, :text, null: false
      add :name, :text

      timestamps(type: :utc_datetime_usec)
    end

    create unique_index(:contacts, [:phone_number])
  end
end
