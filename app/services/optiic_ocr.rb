class OptiicOcr
  BASE_URL = "https://api.optiic.dev/parse"
  API_KEY = ENV.fetch("Cye9adQiWPNiKhE3fEDBY78pMCZgDcCEiFcfSKR1Ak4N")

  def self.scan(file)
    uri = URI(BASE_URL)

    request = Net::HTTP::Post::Multipart.new uri.path,
      "file" => UploadIO.new(file.tempfile, file.content_type, file.original_filename)
    request["Authorization"] = "Bearer #{API_KEY}"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(request)
    data = JSON.parse(response.body)

    if response.code == "200"
      { success: true, text: data["parsedText"] }
    else
      { success: false, error: data["error"] || "Erro desconhecido" }
    end
  end
end
