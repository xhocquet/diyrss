class FaviconService
  attr_accessor :host, :uri, :base64

  def initialize(url)
    @host = URI(url).host
    check_for_ico_file
  end


  # Check /favicon.ico
  def check_for_ico_file
    uri = URI::HTTP.build({:host => @host, :path => '/favicon.ico'}).to_s
    res = Mechanize.new.get(uri)

    if res.code == 200
      @base64 = Base64.encode64(res.body)
      @uri = uri
    end
  end
end
