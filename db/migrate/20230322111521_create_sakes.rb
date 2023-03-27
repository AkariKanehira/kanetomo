class CreateSakes < ActiveRecord::Migration[6.1]
  def change
    create_table :sakes do |t|
      t.string :cocktail
      t.string :image
      t.string :body

      t.timestamps
    end
  end
end
