require 'socket'
require 'byebug'
require 'json'

class WebClient

  host = 'localhost'                # The web server
  port = 2000                       # Default HTTP port
  path = "/index.html"              # The file we want

  attr_accessor :result, :host, :port, :path

  def initialize
    @host = 'localhost'
    @port = 2000
    @path = "/index.html"
    @result = {}
    process_request(handle_request)
  end

  def viking_name
    puts "What is your viking name?"
    name = gets.chomp
  end

  def viking_email
    puts "What is your email?"
    email = gets.chomp
  end

  def user_request
    puts "What type of request do you want to send? (GET or POST)"
    action = gets.chomp.upcase
  end

  def handle_request
    if user_request == "POST"
      @result[:viking] = {:name => viking_name, :email => viking_email}
      @result = result.to_json
      request = "POST #{path} HTTP/1.0\r\nContent-Type: text/json\r\nContent-Length: #{result.length}\r\n\r\n#{result}"
    else
      request = "GET #{path} HTTP/1.0\r\n\r\n"
    end
  end

  def process_request(request)
    socket = TCPSocket.open(host,port)  # Connect to server
    socket.print(request)               # Send request
    response = socket.read              # Read complete response

    print response
  end
  
end

if $PROGRAM_NAME == __FILE__
  new_request = WebClient.new
end
