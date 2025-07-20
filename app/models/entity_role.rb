class EntityRole < ApplicationRecord
  belongs_to :entity
  belongs_to :role
end
