class SerializableAnswer < JSONAPI::Serializable::Resource
  type 'answers'

  attributes :id, :text, :average_rating

  belongs_to :question
  belongs_to :user
end
