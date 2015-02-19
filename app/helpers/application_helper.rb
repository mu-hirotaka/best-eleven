module ApplicationHelper

  def document_title
    '俺ブン'
  end

  private
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def is_smartphone?
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return true if agent.match(m)
    end
    return false
  end
end
