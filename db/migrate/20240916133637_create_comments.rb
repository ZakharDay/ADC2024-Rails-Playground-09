class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :author
      t.text :content
      t.references :pin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
