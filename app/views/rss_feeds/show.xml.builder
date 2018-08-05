#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title @rss_feed.name
    xml.description "Updates for your feed"
    xml.link @rss_feed.url
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => @rss_feed.url
    xml.language "en"

    @rss_feed.notifications.limit(25).each do |notif|
      xml.item do
        xml.title "#{notif.created_at.to_formatted_s(:short)} - #{notif.relevant_thing.name}"
        xml.pubDate notif.created_at.to_s(:rfc822)
        xml.link Rails.application.routes.url_helpers.redirect_url(notif)
        xml.guid Rails.application.routes.url_helpers.redirect_url(notif)

        text = "#{notif.relevant_thing.name} - <a href='#{Rails.application.routes.url_helpers.redirect_url(notif)}'>#{notif.relevant_thing.url}</a>"

        xml.description "New updates for your app monitor: <br>" + text
      end
    end
  end
end
