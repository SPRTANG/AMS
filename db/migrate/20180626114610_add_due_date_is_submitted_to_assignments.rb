class AddDueDateIsSubmittedToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :due_date, :date
    add_column :assignments, :is_submitted, :boolean
  end
end
