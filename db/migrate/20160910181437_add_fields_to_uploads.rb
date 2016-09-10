class AddFieldsToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :arm_image, :string
  end
end
