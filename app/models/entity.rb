class Entity < ApplicationRecord
  validates :full_name, presence: true

  has_many :sent_parcels, foreign_key: :sender_id, class_name: 'Parcel', dependent: :nullify
  has_many :received_parcels, foreign_key: :recipient_id, class_name: 'Parcel', dependent: :nullify
  has_many :registered_parcels, foreign_key: :registered_by_id, class_name: 'Parcel', dependent: :nullify

  has_many :contacts, dependent: :destroy
  has_many :entity_roles, dependent: :destroy
  has_many :roles, through: :entity_roles
  belongs_to :role, optional: true

  accepts_nested_attributes_for :contacts, allow_destroy: true
end
