class Flespi
  require 'json'
  require 'net/http'
  require 'uri'

  # Variables
  attr_accessor :flespi_token, :debug

  # Class constructor
  def initialize(flespi_token, debug= false)
    self.debug = debug
    self.flespi_token = flespi_token
  end

  def get(url)
    uri = URI.parse("https://flespi.io#{url}")

    if self.debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: GET https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Get.new(uri)
    
    return self.validate_response(self.make_request(request, uri))
  end

  def create(url, parameters)
    uri = URI.parse("https://flespi.io#{url}")

    if self.debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: POST https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Post.new(uri)

    return self.validate_response(self.make_request(request, uri, parameters))
  end

  def update(url, parameters)
    uri = URI.parse("https://flespi.io#{url}")

    if self.debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: PUT https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Put.new(uri)

    return self.validate_response(self.make_request(request, uri, parameters))
  end

  def delete(url)
    uri = URI.parse("https://flespi.io#{url}")

    if self.debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: DELETE https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Delete.new(uri)
    
    return self.validate_response(self.make_request(request, uri))
  end

  protected
    def make_request(request, uri, parameters = nil)
      request["Accept"] = "application/json"
      request["Authorization"] = "FlespiToken #{self.flespi_token}"

      if !parameters.nil?
        if self.debug
          puts "================ FLESPI PARAMS ================"
          puts "Parameters: #{parameters.inspect}"
          puts "==============================================="
        end
        request.body = JSON.dump(parameters)
      end

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      return response
    end

    def validate_response(response)
      case response.code.to_i
      when 200
        return { error: false, message: JSON.parse(response.body) }
      when 400
        return { error: true, message: "Invalid parameters", reason: JSON.parse(response.body) }
      when 401
        return { error: true, message: "Invalid or missing flespi token" }
      when 403
        return { error: true, message: "Flespi token blocked" }
      else
        return { error: true, message: "Flespi internal server error" }
      end
    end
end