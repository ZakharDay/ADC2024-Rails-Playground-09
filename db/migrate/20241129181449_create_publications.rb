class CreatePublications < ActiveRecord::Migration[7.2]
  def change
    create_table :publications do |t|
      t.string :type
      t.string :title
      t.text :body
      t.text :embed

      t.timestamps
    end
  end
end
