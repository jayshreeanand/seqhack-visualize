class AddPositionFieldsToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :front_image_details, :text
    add_column :uploads, :back_image_details, :text
    add_column :uploads, :arm_image_details, :text
  end
end
