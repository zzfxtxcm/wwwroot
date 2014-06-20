class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.string :style
      t.string :information_thumb
      t.string :keywords
      t.text :description
      t.text :content
      t.integer :status
      t.string :source

      t.timestamps
    end
  end
end
