class AddImageToPoeets < ActiveRecord::Migration[5.2]
  def change
    add_column :poeets, :image, :text
  end
end
