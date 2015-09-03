require "socket"


module FakeSmtp
  def self.log(*msg)
    puts msg.join(" ")
  end

  class Server
    def initialize(host="localhost", port=2025)
      @host = host
      @port = port
    end

    def run
      FakeSmtp.log("Listening on #{@host} #{@port}.")
      server = TCPServer.new(@host, @port)
      loop { spawn handle_client(server.accept) }
    end

    def handle_client(socket)
      SmtpSession.new(socket).run
    end
  end

  class Session
    property done

    def initialize(io: IO)
      @socket = io
      @done = false
      @handlers = {} of (Symbol|Regex) => CmdHandler
    end

    def on(key, &handler : CmdHandler)
      h = @handlers
      h[key] = handler
    end

    def run
      FakeSmtp.log("New session.")
      until done
        break unless cmd = read_line
        handle_command cmd
      end

      @socket.close
      FakeSmtp.log("Session finished: #{@socket}.")
    end

    def handle_command(command)
      @handlers.keys.each do |re|
        next unless re.is_a? Regex
        if re =~ command
          @handlers[re].call(self, command)
          break
        end
      end
    end

    def respond_with(msg)
      FakeSmtp.log("Response: [#{msg}].")
      @socket.puts msg
    end

    def read_line
      line = @socket.gets
      line = line ? line.rstrip : line
      FakeSmtp.log("READ: [#{line}]")
      line
    end
  end

  class SmtpSession < Session
    def initialize(io: IO)
      super
      on :start do |s|
        s.respond_with "220 smtp.example.com SMTP FakeSmtp"
        nil
      end

      on /^HELO|^EHLO/ do |s, cmd|
        unless cmd.is_a?(Nil)
          words = cmd.split(" ")
  	      s.respond_with "250: Hello #{words[1]} I am glad to meet you"
        end
        nil
      end

      on /^QUIT/ do |s, ftp|
        s.respond_with("221 Bye")
        s.done = true
        nil
      end

      on /^DATA/ do |s, cmd|
        s.respond_with "354 End data with <CR><LF>.<CR><LF>"
        while line = read_line
          break if line == "."
        end
        s.respond_with("250 OK: queued as #{rand(1000)}")
        nil
      end

      on /.*/ do |s, cmd|
        s.respond_with("250 OK")
        nil
      end
    end
  end

  alias CmdHandler = Proc(Session, String, Nil)
end
