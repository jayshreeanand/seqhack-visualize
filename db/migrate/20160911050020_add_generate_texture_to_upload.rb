class AddGenerateTextureToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :generated_texture, :string
  end
end
