class Parcel < ApplicationRecord
  belongs_to :sender, class_name: 'Entity'
  belongs_to :recipient, class_name: 'Entity'
  belongs_to :registered_by, class_name: 'Entity'
  belongs_to :origin_branch, class_name: 'Branch'
  belongs_to :destination_branch, class_name: 'Branch'
  

  has_one :delivery, dependent: :destroy
  has_one :payment, dependent: :destroy

  has_many :sent_parcels, class_name: "Parcel", foreign_key: "sender_id"
  has_many :received_parcels, class_name: "Parcel", foreign_key: "recipient_id"
end
