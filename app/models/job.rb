class Job < ApplicationRecord
  belongs_to :user ,optional: true
  has_many :notifications,dependent: :destroy
  validates :details, presence: true,
            length: { minimum: 5 }

  validates :source_lat, presence: true

  validates :source_long, presence: true

  validates :destination_lat, presence: true

  validates :destination_long, presence: true
end

