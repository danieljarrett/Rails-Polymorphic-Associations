class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.references :item, polymorphic: true
    	t.text :body, null: false
      t.references :user
      t.timestamps
    end
  end
end