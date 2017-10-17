require "rulers/version"
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, { 'Content-Type' => 'text/html' }, []]
      end

      if env['PATH_INFO'] == '/'
        env['PATH_INFO'] = '/quotes/a_quote'
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        [200, { 'Content-Type' => 'text/html' },
        [text]]
      rescue
        [500, { 'Content-Type' => 'text/html' }, ['This is bad!']]
      end
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
