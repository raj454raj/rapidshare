class RemoveFilePathFromDocument < ActiveRecord::Migration
  def change
    remove_column :documents, :file_path, :string
  end
end
