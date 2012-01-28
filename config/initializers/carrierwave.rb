CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET']
  }
  config.fog_directory = 'inthisapp'

  # use only one of the following 2 settings
  config.fog_host = "http://inthisapp.s3.amazonaws.com"
  # config.fog_host = ENV['S3_CDN'] # for cloudfront
end