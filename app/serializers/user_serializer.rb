class UserSerializer < ActiveModel::Serializer
  has_many :jobs
  attributes :id,:status,:email,:user_type,:job_assigned
end
