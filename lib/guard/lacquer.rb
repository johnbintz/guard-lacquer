require 'guard'
require 'guard/guard'
require 'lacquer'
require 'lacquer/varnishd'

p "made it"

module Guard
  class Lacquer < Guard::Guard
    def initialize(watchers = [], options = {})
      super

      @backend = ::Lacquer::Varnishd.new(
        :listen => "127.0.0.1:#{options[:port]}",
        :storage => "file,tmp/cache/varnish.store,32M",
        :backend => options[:backend],
        :sbin_path => File.split(`which varnishd`).first,
        :pid_file => 'tmp/pids/varnish.pid'
      )
    end

    def start
      @backend.start
    end

    def stop
      @backend.start stop
    end

    def reload
      stop
      start
    end

    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_change(paths)
      restart
    end

    # Called on file(s) deletions
    def run_on_deletion(paths)
      restart
    end
  end
end

