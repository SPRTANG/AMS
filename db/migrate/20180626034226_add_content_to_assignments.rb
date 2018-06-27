class AddContentToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :content, :blob
  end
end
