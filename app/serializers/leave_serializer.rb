class LeaveSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :reason, :user_id, :status
end
