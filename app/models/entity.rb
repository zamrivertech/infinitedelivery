class Entity < ApplicationRecord
  validates :full_name, presence: true
  validates :nationality, presence: true
  validates :id_type, presence: true
  validates :id_number, presence: true
  validates :gender, presence: true

  has_many :sent_parcels, foreign_key: :sender_id, class_name: 'Parcel', dependent: :nullify
  has_many :received_parcels, foreign_key: :recipient_id, class_name: 'Parcel', dependent: :nullify

  has_many :contacts, dependent: :destroy
  has_many :entity_roles, dependent: :destroy
  has_many :roles, through: :entity_roles
  belongs_to :role, optional: true

  has_many :addresses, inverse_of: :entity, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true


  def sent_count
    sent_parcels.size
  end

  def received_count
    received_parcels.size
  end

  accepts_nested_attributes_for :contacts, allow_destroy: true
end
