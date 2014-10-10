class CreateUserQuestionRequests < ActiveRecord::Migration
  def change
    create_table :user_question_requests do |t|
      t.string :comment
      t.timestamps
    end
  end
end
