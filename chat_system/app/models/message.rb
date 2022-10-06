class Message < ApplicationRecord
  include Searchable
  belongs_to :chat
  validates :body, presence: true

  def as_json(option = {})
    super(except: %i[id created_at updated_at])
  end
end
