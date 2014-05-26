require "open-uri"
require "json"

module ApplicationHelper
  def join_city
    url = "http://ip.taobao.com/service/getIpInfo.php?ip="
    ip_data = JSON(open("#{url}#{request.remote_ip}").gets)
    city = ip_data["data"]["city"]
    case city
      when "漳州市"
        "http://zz.xinwowang.com"
      when "厦门市"
        "http://xm.xinwowang.com"
      when "泉州市"
        "http://qz.xinwowang.com"
      when "广州市"
        "http://gz.xinwowang.com"
      when "深圳市"
        "http://sz.xinwowang.com"
    end
  end
end
