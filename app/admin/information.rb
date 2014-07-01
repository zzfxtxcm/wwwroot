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
      f.form_buffers.last << javascript_tag("
        $(document).ready(function() {
          var informationType = \"#{f.object.information_type_id}\".replace(/(.)(?=[^$])/g,\"$1,\").split(\",\")

          for (var i = 0; i <= informationType.length; i++) {
            $(\"#information_information_type_id_\" + informationType[i]).prop(\"checked\", true);
          };
        });
      ")
      f.input :information_type,
              :as => :check_boxes,
              :multiple => true,
              :label => I18n.t("active_admin.information.form.information_type")
      f.input :title,
              :label => I18n.t("active_admin.information.form.title")
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

  controller do
    def selected_values
      object.send(method).try(:compact).map(&:to_i) || []
    end
    def information_type
      self.information_type_id ? true : nil
    end

    def permitted_params
      params[:information][:information_type_id] = params[:information][:information_type_id].join(',')
      params.permit!
    end
  end

end
