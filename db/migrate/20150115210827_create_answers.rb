class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.references :question
      t.text :body, null: false
      t.references :user
      t.timestamps
    end
  end
end