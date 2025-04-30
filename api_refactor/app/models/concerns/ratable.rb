module Ratable
  extend ActiveSupport::Concern

  def average_rating
    return nil if ratings.empty?
    ratings.map(&:to_i).sum / ratings.size.to_f
  end
end
