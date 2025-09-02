class Parcel < ApplicationRecord
  validates :parcel_code, presence: true
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :origin_branch_id, presence: true
  validates :destination_branch_id, presence: true
  validates :contents_description, presence: true
  validates :weight_kg, presence: true
  validates :value_mzn, presence: true

  belongs_to :sender, class_name: 'Entity'
  belongs_to :recipient, class_name: 'Entity'
  belongs_to :origin_branch, class_name: 'Branch'
  belongs_to :destination_branch, class_name: 'Branch'
  
  has_one :delivery, dependent: :destroy
  has_one :payment, dependent: :destroy

  has_many :sent_parcels, class_name: "Parcel", foreign_key: "sender_id"
  has_many :received_parcels, class_name: "Parcel", foreign_key: "recipient_id"

  before_save :generate_parcel_code

  def generate_parcel_code
    return if parcel_code.present?
    return unless origin_branch && destination_branch

    origin_code = origin_branch.code || origin_branch.name[0..2].upcase
    dest_code   = destination_branch.code || destination_branch.name[0..2].upcase
    sequence    = Parcel.maximum(:id).to_i + 1

    self.parcel_code = "#{origin_code}#{dest_code}-#{sequence.to_s.rjust(3, '0')}"
  end

end
