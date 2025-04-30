# frozen_string_literal: true

class StatisticsController < ApplicationController
  # We want to return the following statistics:
  # Average number of tags per question
  # Average number of answers per question
  # Top 5 users by questions answered
  # Average answer rating per question with n tags, to see if there is a correlation between tags and answer quality

  def index
    @answer_rating_per_tag_count = {}
    @tags_per_question = []
    @answers_per_question = []


    Question.find_each do |q|
      if @answer_rating_per_tag_count[q.tags.size]
        @answer_rating_per_tag_count[q.tags.size].push(*q.answers.map(&:average_rating))
      else
        @answer_rating_per_tag_count[q.tags.size] = q.answers.map(&:average_rating)
      end

      @tags_per_question.push(q.tags.size)
      @answers_per_question.push(q.answers.size)
    end

    queue = []
    User.find_each do |user|
      queue.push(user, user.answers.size)
    end

    @top_5_users = User.all.sort_by { |u| u.answers.size }.reverse[0..4]
    @answer_rating_per_tag_count = @answer_rating_per_tag_count.transform_values { |v| v.sum / v.size }
    @tags_per_question = @tags_per_question.sum / @tags_per_question.size
    @answers_per_question = @answers_per_question.sum / @answers_per_question.size
  end
end
