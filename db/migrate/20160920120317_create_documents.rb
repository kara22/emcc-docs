class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|

      t.string :name
      t.string :tagline
      t.string :category

      t.timestamps
    end
  end
end
