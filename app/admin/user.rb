ActiveAdmin.register User do
  jcropable

  filter :email

  index do
    id_column
    column :email
    column :front_image do |user|
      image_tag user.front_image.thumb.url
    end
    column :back_image do |user|
      image_tag user.back_image.thumb.url
    end
    column :arm_image do |user|
      image_tag user.arm_image.thumb.url
    end
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      if f.object.id.nil?
        f.input :password
      end
      f.input :front_image, as: :jcropable, jcrop_options: { showDimensions: true }
      f.input :back_image, as: :jcropable, jcrop_options: { showDimensions: true }
      f.input :arm_image, as: :jcropable, jcrop_options: { showDimensions: true }

    end
    f.actions
  end


end
