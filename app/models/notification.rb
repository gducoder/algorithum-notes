class Notification < ApplicationRecord
  belongs_to :user,optional: true
  belongs_to :job
end
