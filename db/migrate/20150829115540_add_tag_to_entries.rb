class AddTagToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :tag, :string
  end
end
