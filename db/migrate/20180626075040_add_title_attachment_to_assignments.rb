class AddTitleAttachmentToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :title, :string
    add_column :assignments, :attachment_path, :string
  end
end
