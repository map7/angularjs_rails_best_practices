class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :name
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
