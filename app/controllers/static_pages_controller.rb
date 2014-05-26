require "open-uri"
require "json"
include StaticPagesHelper

class StaticPagesController < ApplicationController
  def home
    join_city
  end

  private
    def join_city
      url = "http://ip.taobao.com/service/getIpInfo.php?ip="
      @ip_data = JSON(open("#{url}#{request.remote_ip}").gets)
      @city = @ip_data["data"]["city"]
      case @city
        when "漳州市"
          auto_redirect(:sec => '5', :url => "http://zz.xinwowang.com")
        when "厦门市"
          auto_redirect(:sec => '5', :url => "http://xm.xinwowang.com")
        when "泉州市"
          auto_redirect(:sec => '5', :url => "http://qz.xinwowang.com")
        when "广州市"
          auto_redirect(:sec => '5', :url => "http://gz.xinwowang.com")
        when "深圳市"
          auto_redirect(:sec => '5', :url => "http://sz.xinwowang.com")
      end
    end
end
