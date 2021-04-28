namespace :get do
  task :pictures => :environment do
    GetPictures.log_output
  end
end