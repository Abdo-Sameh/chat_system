class Chat < ApplicationRecord
  has_many :messages
  belongs_to :application

  def as_json(option={})
    super(except: %i[id created_at updated_at])
  end

end
