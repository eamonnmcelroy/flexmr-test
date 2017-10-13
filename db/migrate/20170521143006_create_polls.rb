class CreatePolls < ActiveRecord::Migration[5.1]
  def up
    create_table :polls do |t|
      t.string :title
      t.string :question

      t.belongs_to :user

      t.timestamps
    end
  end

  def down
    drop_table :polls
  end
end
