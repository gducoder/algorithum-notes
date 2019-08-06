class JobSerializer < ActiveModel::Serializer
  belongs_to :user ,optional: true
  attributes :id,:status,:source_lat,:source_long,:destination_lat,:destination_long,:details,:user_id
end
