require 'uri'
class GetPictures
  def self.log_output
    response_zum_donner = RestClient::Request.new(
        :method => :get,
        :url => "https://ist-ur.org/photos/484.json"
    ).execute
    results = JSON.parse(response_zum_donner.to_s)
    puts results.inspect
    micropost = Micropost.find('2f4c2d65-8ed8-4028-9f35-139295c4a073')
    puts micropost.inspect
    results.each_pair do |key, value|
      if key == "picture"
        value.each_pair do |k, v|
          puts "#{k}: #{v}"
          if k == 'url'
            a = URI.parse(v)
            puts a.inspect
            # filename = File.basename(URI.parse(a))
            p = micropost.photos.create!
            p.image.attach(io: open(v), filename: 'Anden.jpg')
            puts '++++++++++++'
            # puts filename.inspect
            puts '++++++++++++++'
          end
        end
      end
    end
    puts results.class
    puts results.keys
    # filename = File.basename(URI.parse(results.picture.url))
  end
end