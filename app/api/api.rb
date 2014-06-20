module Wwwroot
  class API < Grape::API
    format :json

    resource :api do

      desc "Return information"
      get do
        Information.all
      end

    end

  end
end
