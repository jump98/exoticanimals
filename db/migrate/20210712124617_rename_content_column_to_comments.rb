class RenameContentColumnToComments < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :content, :comment
  end
end