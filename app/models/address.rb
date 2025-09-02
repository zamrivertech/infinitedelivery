class Address < ApplicationRecord
  belongs_to :entity

  validate :postal_code_within_province_range

  def postal_code_within_province_range
    return if region.blank? || postal_code.blank?

    # Extract raw province name from label
    province = region[/^[^()]+/]&.strip
    range = MOZAMBIQUE_POSTAL_CODE_RANGES[province]

    unless range&.include?(postal_code.to_i)
      errors.add(:postal_code, "deve estar entre #{range.first} e #{range.last} para #{province}")
    end
  end


  validates :address_type, :street_line_1, :city, :country, :region, presence: true

  def full_address
    [street_line_1, street_line_2, neighborhood, city, region, postal_code, country].compact.join(', ')
  end
end
