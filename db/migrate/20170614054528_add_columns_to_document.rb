class AddColumnsToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :documentname, :string
    add_column :documents, :documenttype, :string
    add_column :documents, :contents, :binary
  end
end
