json.extract! note_attachment, :id, :note_id, :avatar, :created_at, :updated_at
json.url note_attachment_url(note_attachment, format: :json)
