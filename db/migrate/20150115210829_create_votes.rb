class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :item, polymorphic: true
      t.boolean :value
			t.references :user
      t.timestamps
    end
  end
end