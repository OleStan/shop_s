ActiveAdmin.register Product do
  permit_params :price, :about, :config, :photo, :article, :factory, :name, :category_id
  form title: 'Create Product' do |f|
    f.semantic_errors
    f.inputs do
      input :name
      input :category
      input :article
      input :price
      input :about, as: :text
      input :config, as: :text
      input :factory
      input :photo, as: :file
    end
    f.actions
  end
end

