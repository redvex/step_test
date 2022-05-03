require 'ostruct'
module Sfn
  def self.configuration
    @configuration ||= OpenStruct.new
  end
  
  def self.configure
    yield(configuration)
  end
end