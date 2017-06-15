class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :documentname
      t.string :documenttype
      t.string :storedfile_name
      t.boolean :is_public
      t.references :user, index: true

      t.timestamps
    end
  end
end
