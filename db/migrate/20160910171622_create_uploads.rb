class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :user
      t.string :front_image
      t.string :back_image
      t.timestamps null: false
    end
  end
end
