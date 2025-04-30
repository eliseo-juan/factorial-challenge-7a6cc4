# frozen_string_literal: true

class Answer < ApplicationRecord
  include Ratable
  serialize :ratings, type: Array

  belongs_to :user
  belongs_to :question

  validates :text, presence: true
end
