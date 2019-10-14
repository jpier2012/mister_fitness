class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :name
      t.string :description
      t.string :instructions
      t.timestamps
    end
  end
end
