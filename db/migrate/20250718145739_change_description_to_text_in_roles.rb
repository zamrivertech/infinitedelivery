class ChangeDescriptionToTextInRoles < ActiveRecord::Migration[8.0]
  def change
    change_column :roles, :description, :text
  end
end
