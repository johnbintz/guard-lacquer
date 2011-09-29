require 'guard/lacquer'

require 'lacquer'
require 'lacquer/varnishd'

class Guard::Lacquer::Varnishd < ::Lacquer::Varnishd
  attr_accessor :pid_dir

  def self.root_path
    Pathname.new(Dir.pwd)
  end

  def self.env
    ENV['RAILS_ENV'] || 'development'
  end

  def self.app_name
    self.name.downcase.split("::").last
  end

  def initialize(options)
    if options[:backend].split(':').first.empty?
      options[:backend] = "127.0.0.1#{options[:backend]}"
    end

    options[:working_dir] ||= options[:name]
    self.pid_dir = options[:pid_dir] || 'tmp/pids'

    options[:listen] = "127.0.0.1:#{options[:port]}"

    super(Hash[options.collect { |k, v| [ k.to_s, v ] }])
  end

  def pid_file
    self.class.root_path.join(self.pid_dir).join("#{self.class.app_name}.#{self.class.env}.pid")
  end
end

