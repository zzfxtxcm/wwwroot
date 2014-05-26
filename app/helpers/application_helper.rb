require "open-uri"
require "json"

module ApplicationHelper
  def join_city
    url = "http://ip.taobao.com/service/getIpInfo.php?ip="
    ip_data = JSON(open("#{url}#{request.remote_ip}").gets)
    city = ip_data["data"]["city"]
    case city
      when "漳州市"
        "zz"
      when "厦门市"
        "xm"
      when "泉州市"
        "qz"
      when "广州市"
        "gz"
      when "深圳市"
        "sz"
    end
  end
end
