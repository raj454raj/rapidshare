class AddIsPublicToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :is_public, :boolean
  end
end
