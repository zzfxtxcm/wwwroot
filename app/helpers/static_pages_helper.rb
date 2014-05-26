module StaticPagesHelper
  def auto_redirect(arg={})
    sec = arg[:sec] || 3
    url = arg[:url] || '/'
    eval("render :text=>\"<meta http-equiv='refresh' content='#{sec}; url=#{url}'>\"")
  end
end
