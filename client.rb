require 'bundler/setup'
require 'yaml'
require_relative 'chinanet'

def connect
  config = YAML.load_file('config.yml')
  cn = Chinanet.new(config)

  cn.login
  puts 'Log in'
  begin
    loop do
      cn.keep_alive
      puts 'Keep alive'
      sleep 60
    end
  ensure
    cn.logout
    puts 'Logout'
  end
end

# Reconnect automatically
loop do
  begin
    puts 'Start'
    connect
  rescue Interrupt
    exit
  rescue StandardError => e
    puts e
    puts e.backtrace.join("\n")
  end
end
