module LogjamAgent
  module Forwarders
    @@forwarders = {}

    extend self

    def add(f)
      @@forwarders["#{f.app}-#{f.env}"] = f
    end

    def get(app, env)
      @@forwarders["#{app}-#{env}"]
    end

    def reset
      @@forwarders.each_value {|f| f.reset}
    end

    # properly close open sockets on program termination
    at_exit { reset }

    def inspect
      super + ": #{@@forwarders.inspect}"
    end
  end
end
