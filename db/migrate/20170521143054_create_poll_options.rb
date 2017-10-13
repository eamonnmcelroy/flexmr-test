class CreatePollOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_options do |t|
      t.string :text
      
      t.belongs_to :poll

      t.timestamps
    end
  end
end
