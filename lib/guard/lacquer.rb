require 'guard'
require 'guard/guard'

require 'fileutils'

module Guard
  class Lacquer < Guard
    autoload :Varnishd, 'guard/lacquer/varnishd'
    autoload :VarnishNCSA, 'guard/lacquer/varnishncsa'

    def initialize(watchers = [], options = {})
      super

      @options = {
        :port => 3001,
        :backend => '127.0.0.1:3000',
        :storage => 'file,tmp/cache/varnish.store,32M',
        :pid_dir => 'tmp/pids',
        :log_dir => 'log',
        :name => File.split(Dir.pwd).last
      }.merge(options)

      if @options[:varnish_path]
        @options.merge!(
          :sbin_path => File.join(@options[:varnish_path], 'sbin'),
          :bin_path => File.join(@options[:varnish_path], 'bin'),
        )
      else
        @options.merge!(
          :sbin_path => File.split(`which varnishd`.strip).first,
          :bin_path => File.split(`which varnishncsa`.strip).first
        )
      end

      @runners = [ Varnishd.new(@options) ]
      @runners << VarnishNCSA.new(@options) if @options[:log_dir]

      if !File.file?(varnish_erb = 'config/varnish.vcl.erb')
        UI.info "No config/varnish.vcl.erb found, copying default from Lacquer..."

        FileUtils.mkdir_p File.split(varnish_erb).first
        FileUtils.cp Gem.find_files('generators/lacquer/templates/varnish.vcl.erb').first, varnish_erb
      end
    end

    def start
      @runners.each do |which|
        which.stop if which.running?
        which.start
      end

      notify "Varnish started on port #{@options[:port]}, with backend #{@options[:backend]}."
    end

    def stop
      @runners.each(&:stop)

      notify "Until next time..."
    end

    def reload
      true
    end

    def run_all
      stop
      start
    end

    # Called on file(s) modifications
    def run_on_change(paths)
      run_all
    end

    # Called on file(s) deletions
    def run_on_deletion(paths)
      run_all
    end

    private
    def notify(message)
      Notifier.notify(message, :title => 'guard-lacquer', :image => File.expand_path("../../../images/varnish.png", __FILE__))
    end
  end
end

