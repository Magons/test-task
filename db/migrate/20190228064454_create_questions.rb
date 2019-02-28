class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :body
      t.string :answer_choices, array: true, default: []

      t.timestamps
    end
  end
end
