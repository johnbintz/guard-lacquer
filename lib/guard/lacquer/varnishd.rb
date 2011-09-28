require 'lacquer'
require 'lacquer/varnishd'

class Guard::Lacquer::Varnishd < ::Lacquer::Varnishd
  attr_accessor :pid_file

  def self.root_path
    Pathname.new(Dir.pwd)
  end

  def self.env
    ENV['RAILS_ENV'] || 'development'
  end

  def initialize(options)
    if options[:backend].split(':').first.empty?
      options[:backend] = "127.0.0.1#{options[:backend]}"
    end
    self.pid_file = self.class.root_path.join(options[:pid_file])
    options[:listen] = "127.0.0.1:#{options[:port]}"

    super(Hash[options.collect { |k, v| [ k.to_s, v ] }])
  end
end

