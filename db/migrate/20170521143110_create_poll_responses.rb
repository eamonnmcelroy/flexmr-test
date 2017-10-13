class CreatePollResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :poll_responses do |t|
      t.belongs_to :poll
      t.belongs_to :user
      t.belongs_to :poll_option

      t.timestamps
    end
  end
end
