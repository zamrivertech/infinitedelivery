class Branch < ApplicationRecord
  has_many :origin_parcels, foreign_key: :origin_branch_id, class_name: 'Parcel', dependent: :nullify
  has_many :destination_parcels, foreign_key: :destination_branch_id, class_name: 'Parcel', dependent: :nullify
end
