class CreateGazos < ActiveRecord::Migration
  def change
    create_table :gazos do |t|
      t.string :file
      t.string :comment
      t.string :ctype
      t.binary :image

      t.timestamps
    end
  end
end
