class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :type
      t.integer :progress
      t.integer :activity_id

      t.timestamps
    end
  end
end
