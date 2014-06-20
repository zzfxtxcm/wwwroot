ActiveAdmin.register Information do


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  menu :label => proc{ I18n.t("active_admin.information.menu.information") }

  permit_params :title, :source, :keywords, :description, :content

  index :title => proc{ I18n.t("active_admin.information.title") } do
    selectable_column
    id_column
    column I18n.t("active_admin.information.list.title"), :title
    column I18n.t("active_admin.information.list.source"), :source
    actions
  end

  filter :title, :label => I18n.t("active_admin.information.search.title")
  filter :source, :label => I18n.t("active_admin.information.search.source")
  filter :information_type, :label => I18n.t("active_admin.information.search.information_type")
  filter :created_at,
         :label => I18n.t("active_admin.information.search.created_at")

  form do |f|
    f.inputs "" do
      f.input :title,
              :label => I18n.t("active_admin.information.form.title")
      # f.input :information_thumb,
      #         :label => I18n.t("active_admin.information.form.information_thumb")
      f.input :source,
              :label => I18n.t("active_admin.information.form.source")
      f.input :keywords,
              :label => I18n.t("active_admin.information.form.keywords")
      f.input :description,
              :label => I18n.t("active_admin.information.form.description"),
              :input_html => { :rows => 5 }
      f.input :content,
              :label => I18n.t("active_admin.information.form.content"),
              :as => :ckeditor
    end
    f.actions
  end

end
