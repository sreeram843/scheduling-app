class Qualification < ApplicationRecord
  belongs_to :practitioner

  has_many :qualification_identifiers, dependent: :destroy
end
