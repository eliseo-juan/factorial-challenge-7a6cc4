# frozen_string_literal: true

class Question < ApplicationRecord
  include Ratable
  serialize :ratings, type: Array
  serialize :tags, type: Array

  belongs_to :user, optional: true
  has_many :answers

  validates :text, presence: true

  before_save :remove_duplicate_tags

  # stops someone from assigning the same tags to a question! B)
  def remove_duplicate_tags
    self.tags = tags.uniq
  end
end
