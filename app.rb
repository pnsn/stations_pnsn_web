require "sinatra"
require "sinatra/config_file"
require "rrd"
require "haml"


config_file  './config/app.yml'
set :environment, ENV.has_key?("RACK_ENV") ? ENV["RACK_ENV"] : :development
set :port, settings.port
#this is needed for the vagrant box since Sinatra will bind to localhost by default
set :bind, '0.0.0.0'

get "/" do 
  @stas = find_all_stas
  haml :index
end


get '/:sta' do 
  @sta = params[:sta]
  chans =find_all_chans(@sta)
  @img_urls =[]
  unless chans.blank?
    chans.each do |chan|
      rrd_path= "#{settings.rrd_path}/#{chan}"
      rrd = RRD::Base.new(rrd_path)
      if rrd
        img_path = "#{settings.rrd_img_path}/#{chan.split(".")[0]}.png"
        img_url = "#{settings.rrd_img_url}/#{chan.split(".")[0]}.png"
        title = chan.split("-")[0].upcase + ":"+ chan.split("-")[1].upcase
        @img_urls.push(img_url)
        RRD.graph img_path, :title => title, :width=> 600, :height=> 200, 
                        :start => Time.now - 1.year, :end => Time.now - 1.day, 
                        :color => ["FONT#000000", "BACK#FFFFFF"]  do 
                        line rrd_path, :day_med => :average, :color => "#FF0000"
                      end
      end
    end
  end
  
  haml :show
end



#return hash keyed on channel type of all unique stations with channel data
def find_all_stas  
  all_files=  Dir.entries("#{settings.rrd_path}/").select {|f| !File.directory? f} 
  uniq_files = all_files.uniq {|r| r.split("-").first}
  uniq_files.group_by {|r| r.split("-")[1][0,2]}
end


#return available station's channels
def find_all_chans(sta)
  Dir.entries("#{settings.rrd_path}/").select {|x| x.split("-").first == sta}
end