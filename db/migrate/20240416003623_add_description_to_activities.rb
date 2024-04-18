class AddDescriptionToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :description, :text
  end
end
