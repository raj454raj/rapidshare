class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :attachment
      t.references :user, index: true

      t.timestamps
    end
  end
end
