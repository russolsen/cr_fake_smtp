require "option_parser"
require "./fake_smtp"

port = 2025
host = "localhost"

OptionParser.parse! do |parser|
  parser.banner = "Usage: fake_smtp [arguments]"
  parser.on("-p port", "--port port", "Listen on port (#{port})") {|p| port = p.to_i}
  parser.on("-H host", "--host host", "Listen on host (#{host})") {|h| host = h}
  parser.on("-h", "--help", "Show this help") { puts parser }
end

FakeSmtp::Server.new(host: host, port: port).run
