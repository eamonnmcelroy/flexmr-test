class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :poll_id, null: false
      t.integer :user_id, null: false
      t.text    :comment
      t.timestamps
    end

    add_index :comments, :poll_id
    add_index :comments, :user_id
  end
end
