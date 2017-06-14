class AddFilePathToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :file_path, :string
  end
end
