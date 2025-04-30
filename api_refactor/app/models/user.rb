# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_token

  has_many :questions
  has_many :answers

  validates :email, presence: true
  validates :email, uniqueness: true

  validates :username, presence: true
  validates :username, uniqueness: true
end
