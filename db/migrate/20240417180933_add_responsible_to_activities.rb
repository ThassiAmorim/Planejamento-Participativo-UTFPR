class AddResponsibleToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :responsible, :string
  end
end
