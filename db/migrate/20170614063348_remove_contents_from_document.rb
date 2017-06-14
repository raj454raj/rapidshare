class RemoveContentsFromDocument < ActiveRecord::Migration
  def change
    remove_column :documents, :contents, :binary
  end
end
