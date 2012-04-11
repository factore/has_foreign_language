require 'rspec'

class I18n
  class << self
    attr_accessor :locale, :default_locale
  end
end
require 'has_foreign_language'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end