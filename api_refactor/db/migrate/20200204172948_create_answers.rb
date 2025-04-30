# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string            :text
      t.integer           :user_id
      t.integer           :question_id
      t.text              :ratings

      t.timestamps
    end
  end
end
