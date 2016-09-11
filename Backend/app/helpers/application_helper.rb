module ApplicationHelper
  # Generates javascript array out of flash messages
  def generate_flash_array
    raw(flash.to_a)
  end
end
