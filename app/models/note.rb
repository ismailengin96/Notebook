class Note < ApplicationRecord
  belongs_to :user
  has_many :note_attachments
  accepts_nested_attributes_for :note_attachments
end
