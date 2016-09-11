ActiveAdmin.register Upload do
  jcropable

  index do
    id_column
    column :user
    column :front_image do |upload|
      image_tag upload.front_image.thumb.url
    end
    column :back_image do |upload|
      image_tag upload.back_image.thumb.url
    end
    column :arm_image do |upload|
      image_tag upload.arm_image.thumb.url
    end
  end

  show do
    attributes_table do
      row :user
      row :front_image do
        image_tag upload.front_image.normal.url
      end
      row :back_image do
        image_tag upload.back_image.normal.url
      end
      row :arm_image do
        image_tag upload.arm_image.normal.url
      end
    end
  end

  form do |f|
    f.inputs 'Upload Details' do
      f.input :user
      f.input :front_image, as: :jcropable, jcrop_options: { showDimensions: true }
      f.input :back_image, as: :jcropable, jcrop_options: { showDimensions: true }
      f.input :arm_image, as: :jcropable, jcrop_options: { showDimensions: true }

    end
    f.actions
  end
end
