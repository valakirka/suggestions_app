class AddImageToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :image, :string
  end
end
