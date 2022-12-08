# frozen_string_literal: true

class Astronaut < ApplicationRecord
  scope :search, ->(query) { where("first_name ILIKE ? OR last_name ILIKE ?", "#{query}%", "#{query}%") }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :age, presence: true, numericality: {in: 20..60}
  validates :country_code, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
