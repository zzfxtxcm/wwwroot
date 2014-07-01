module Wwwroot
  class API < Grape::API
    prefix "api"
    format :json

    resource :information do

      desc "Return information"
      get do
        Information.where("information_type_id LIKE ?", "%#{params[:information_type_id]}%").order('created_at DESC')
      end

      # params { requires :information_type_id, :type => String }
      # route_param :information_type_id do
      #   get do
      #     Information.where("id LIKE '%?%'", params[:information_type_id]).order('created_at DESC')
      #   end
      # end

      # desc "Return information type"
      # get ":information_type_id" do
      #   @information_type = Information.where("id LIKE '%?%'", params[:information_type_id]).order('created_at DESC')
      #   present @information_type
      # end

    end

  end
end
