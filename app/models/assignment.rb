class Assignment < ApplicationRecord
  belongs_to :user
  mount_uploader :attachment_path, AssignmentUploader
end
