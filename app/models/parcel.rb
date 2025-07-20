class Parcel < ApplicationRecord
  belongs_to :sender, class_name: 'Entity'
  belongs_to :recipient, class_name: 'Entity'
  belongs_to :registered_by, class_name: 'Entity'
  belongs_to :origin_branch, class_name: 'Entity'
  belongs_to :destination_branch, class_name: 'Entity'

  has_one :delivery, dependent: :destroy
  has_one :payment, dependent: :destroy
end
