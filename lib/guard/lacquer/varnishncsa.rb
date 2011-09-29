require 'guard/lacquer'

class Guard::Lacquer
  class VarnishNCSA < Varnishd
    attr_accessor :bin_path, :log_dir

    def initialize(settings)
      settings[:working_dir] ||= settings[:name]

      self.working_dir, self.bin_path, self.log_dir = settings[:working_dir], settings[:bin_path], settings[:log_dir]

      self.pid_dir = settings[:pid_dir] || 'tmp/pids'
    end

    def start
      if running?
        log("Aready running")
        return
      end
      execute("#{varnishncsa_cmd} #{args}")
    end

    def stop
      if running?
        execute("kill #{pid}")
        pid_file.delete
      else
        log("pid file not found or #{self.class.app_name} not running")
      end
    end

    def options
      opt = {}
      opt["-P"] = pid_file
      opt["-n"] = working_dir if working_dir.present?
      opt["-a"] = '-D'
      opt["-w"] = self.class.root_path.join(self.log_dir).join("varnishncsa.#{self.class.env}.log")
      opt
    end

    protected
    def varnishncsa_cmd
      Pathname.new(self.bin_path).join('varnishncsa')
    end
  end
end

