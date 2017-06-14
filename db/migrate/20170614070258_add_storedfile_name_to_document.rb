class AddStoredfileNameToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :storedfile_name, :string
  end
end
