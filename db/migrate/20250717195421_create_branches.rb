class CreateBranches < ActiveRecord::Migration[8.0]
  def change
    create_table :branches do |t|
      t.string :code
      t.string :name
      t.string :province
      t.string :address

      t.timestamps
    end
  end
end
