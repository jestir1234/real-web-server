require "socket"
require 'byebug'
require 'json'

server = TCPServer.open(2000)

def action(request)
  verb = request.split(" ")[0]
end

def file_request(request)
  file = request.split("/")[1].split(" ")[0]
end

def file_extension(file)
  extension = File.extname(file)
end

def get_response(file)
  file == 'index.html' ? file_found(file) : file_not_found
end

def file_not_found
  return "HTTP/1.0 404 : File not found!"
end

def bad_request
  return "HTTP/1.0 400 : Bad Request"
end

def file_found(file)
  extension = file_extension(file)[1..-1]
  header = "HTTP/1.0 200 OK"
  date = "Date: #{Time.now}"
  content_type = "text/#{extension}"
  content_length = File.read(file).length

  template = File.read("index.html")
  result = "#{header}\r\nDate: #{date}\r\nContent-Type: #{content_type}\r\nContent-Length: #{content_length}\r\n\r\n#{template}"

end

def parse_request(request)
  string = request.split("\r\n\r\n")
  header = string[0]
  params = JSON.parse(string[-1])
  viking_params = params["viking"]
  template = File.read("thanks.html")
  content = ""

  attributes = viking_params.map { |k, v| "<li>#{k}: #{v}</li><br>" }.each { |el| content += el}

  page = template.sub("<%= yield %>", content)

  result = "#{header}\r\n\r\n#{page}"
end


loop {
  # For threading, use 'Thread.start(server.accept) do |client|; end'
    client = server.accept
    puts "Client connected..."

    request = client.recv(1000)
    verb = action(request)
    file = file_request(request)

    if verb == "GET"
      client.print(get_response(file))
    elsif verb == "POST"
      client.print(parse_request(request))
    else
      client.print(bad_request)
    end

    # client.puts(Time.now.ctime)
    puts "Closing the connection. Bye!"
    client.close
}
