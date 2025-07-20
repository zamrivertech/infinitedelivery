class Contact < ApplicationRecord
  validates :value, presence: true

  belongs_to :entity
end
