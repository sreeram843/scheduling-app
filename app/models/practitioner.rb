class Practitioner < ApplicationRecord
  has_many :names
  has_many :credentials
  has_many :contact_informations
  has_many :addresses
  has_many :photos
  has_many :qualifications
  has_many :communications
  has_many :schedules, dependent: :destroy
end
