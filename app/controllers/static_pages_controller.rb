require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
  end

  def search
    @list = []
    keyword = params[:keyword]
    @zz = "http://zz.xinwowang.com"
    @qz = "http://qz.xinwowang.com"
    @gz = "http://gz.xinwowang.com"
    @sz = "http://sz.xinwowang.com"
    # new_homes
    [@zz, @qz, @gz, @sz].map do |city|
      city_list = JSON.parse(open(URI.escape("#{city}/new_homes.json?keyword=#{keyword}")).read)
      get_search_list(city_list, "new_homes")
    end

    # information
    [@zz, @qz, @gz, @sz].map do |city|
      city_list = JSON.parse(open(URI.escape("#{city}/information.json?keyword=#{keyword}")).read)
      get_search_list(city_list, "information")
    end

    @list = @list.paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.json { render json: @list }
      format.js
    end
  end

  private
    def get_search_list(url, model_name)

      url.each do |item|
        @list << [
                  item["name"] ? item["name"] : item["title"],
                  item["description"],
                  "#{@zz}/#{model_name}/#{item["id"]}"
                 ]
      end
    end
end
