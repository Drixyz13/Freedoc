class Doctor < ApplicationRecord
  belongs_to :city
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments, dependent: :destroy
  has_many :doctor_specialties, dependent: :destroy
  has_many :specialties, through: :doctor_specialties, dependent: :destroy

end
