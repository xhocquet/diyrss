class FetchFaviconWorker
  include Sidekiq::Worker

  attr_reader :app_monitor,
              :uri

  def perform(app_monitor_id)
    @app_monitor = AppMonitor.find_by(id: app_monitor_id)
    return if app_monitor.blank?
    return if app_monitor.favicon.attached?

    @uri = URI(app_monitor.url)

    check_for_ico_file
  end

  def check_for_ico_file
    url = URI::HTTP.build({:host => uri.host, :path => '/favicon.ico'}).to_s
    res = Mechanize.new.get(url)

    # Jackpot
    if res.code == "200" && res.class == Mechanize::Image
      contents = StringIO.new(res.body)
      app_monitor.favicon.attach(io: contents, filename: "favicon-#{app_monitor.url.gsub(/\W/,'')}.ico")
    end
  rescue Net::HTTP::Persistent::Error, Mechanize::ResponseCodeError
    return
  end

  def check_for_html_tag
    url = URI::HTTP.build({:host => uri.host, :path => '/'}).to_s
    res = Mechanize.new.get(url)
    doc = Nokogiri::HTML(res.body)
    doc.xpath('//link[@rel="shortcut icon"]').each do |tag|
      taguri = URI(tag['href'])
      unless taguri.host.to_s.length < 1
        iconuri = taguri.to_s
      else
        iconuri = URI.join(uri, taguri).to_s
      end
      res = Mechanize.new.get(iconuri)
      if res.code == 200 && res.class == Mechanize::Image
        contents = StringIO.new(res.body)
        app_monitor.favicon.attach(io: contents, filename: "favicon-#{app_monitor.url.gsub(/\W/,'')}.ico")
      end
    end
  end
end
