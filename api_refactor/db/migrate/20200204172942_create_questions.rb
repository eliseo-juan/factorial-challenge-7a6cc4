# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string            :text
      t.integer           :user_id
      t.text              :tags
      t.text              :ratings

      t.timestamps
    end
  end
end
