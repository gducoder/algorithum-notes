class User < ApplicationRecord


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User
  serialize :tokens

  has_many :jobs
  has_many :notifications
  validates :name, presence: true

  def tokens_has_json_column_type?
    # database_exists? && table_exists? && self.columns_hash['tokens'] && self.columns_hash['tokens'].type.in?([:json, :jsonb])
    database_exists? && table_exists? && self.type_for_attribute('tokens').type.in?([:json, :jsonb])
  end
end
