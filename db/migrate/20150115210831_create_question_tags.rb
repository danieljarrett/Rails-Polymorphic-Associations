class CreateQuestionTags < ActiveRecord::Migration
  def change
    create_table :question_tags do |t|
    	t.references :question
    	t.references :tag
      t.timestamps
    end
  end
end