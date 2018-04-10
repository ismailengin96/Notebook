class NoteAttachment < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	belongs_to :note
end
