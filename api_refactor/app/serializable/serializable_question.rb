class SerializableQuestion < JSONAPI::Serializable::Resource
  type 'questions'

  attributes :id, :text, :tags, :ratings, :user_id, :average_rating

  belongs_to :user
  has_many :answers
end
