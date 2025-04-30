JSONAPI::Rails.configure do |config|
 config.logger = Logger.new('/dev/null') if Rails.env.test?
end
