class AddCathegoryToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :cathegory, :string
  end
end
