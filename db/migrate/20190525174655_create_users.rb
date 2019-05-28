class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :document
      t.integer :kind
      t.integer :status
      t.text :notes

      t.timestamps null: false
    end
  end
end
