#---
# Excerpted from "From Ruby to Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/sbelixir for more book information.
#---
defmodule PhoneAppWeb.MessageHTML do
  use PhoneAppWeb, :html

  embed_templates "message_html/*"

  # Define the attributes that go into the message_form component, located
  # inside of the templates directory.
  alias PhoneApp.Conversations

  attr :changeset, Ecto.Changeset, required: true
  attr :contact, Conversations.Schema.Contact, required: false, default: nil

  def message_form(assigns)

  # <.simple_button text="Deliver" type="submit" />
  attr :type, :string, default: "button", values: ["button", "submit"]
  attr :text, :string, required: true

  def simple_button(assigns) do
    ~H"""
    <button
      type={@type}
      class="rounded border bg-white text-gray-700 px-4 py-2"
    >
      <%= @text %>
    </button>
    """
  end

  # <.slot_button type="submit">
  #   <strong>Strong Button!</strong>
  # </.slot_button>
  attr :type, :string, default: "button", values: ["button", "submit"]
  slot :inner_block, required: true

  def slot_button(assigns) do
    ~H"""
    <button
      type={@type}
      class="rounded border bg-white text-gray-700 px-4 py-2"
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
