class Role < ApplicationRecord
  validates :name, presence: true
  has_many :entity_roles, dependent: :destroy
  has_many :entities, through: :entity_roles
end
