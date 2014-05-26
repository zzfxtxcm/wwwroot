require "open-uri"
require "json"

class StaticPagesController < ApplicationController
  def home

  end

  private
    def join_city
      url = "http://ip.taobao.com/service/getIpInfo.php?ip="
      @ip_data = JSON(open("#{url}#{request.remote_ip}").gets)
      @city = @ip_data["data"]["city"]
      case @city
        when "漳州市"
          redirect_to "http://zz.xinwowang.com"
        when "厦门市"
          redirect_to "http://xm.xinwowang.com"
        when "泉州市"
          redirect_to "http://qz.xinwowang.com"
        when "广州市"
          redirect_to "http://gz.xinwowang.com"
        when "深圳市"
          redirect_to "http://sz.xinwowang.com"
      end
    end
end
