require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
  end

  def search
    @list = []
    keyword = params[:keyword]
    @zz = "http://zz.xinwowang.com"
    @xm = "http://xm.xinwowang.com"
    @qz = "http://qz.xinwowang.com"
    @gz = "http://gz.xinwowang.com"
    @sz = "http://sz.xinwowang.com"
    # new_homes
    [@zz, @xm, @qz, @gz, @sz].each do |city|
      city_list = JSON.parse(open(URI.escape("#{city}/new_homes.json?keyword=#{keyword}&per_page=100")).read)
      get_search_list(city_list, "new_homes", city)
    end

    # information
    [@zz, @xm, @qz, @gz, @sz].each do |city|
      city_list = JSON.parse(open(URI.escape("#{city}/information.json?keyword=#{keyword}&per_page=500")).read)
      get_search_list(city_list, "information", city)
    end

    @list = @list.paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.json { render json: @list }
      format.js
    end
  end

  private
    def get_search_list(url, model_name, city_lnk)
      url.map do |item|
        @list << [
                  item["name"] || item["title"],
                  item["description"],
                  "#{city_lnk}/#{model_name}/#{item["id"]}"
                 ]
      end
    end
end
