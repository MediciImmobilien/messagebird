defmodule Messagebird do
	@api_base_url "https://rest.messagebird.com"
	@config Application.get_env(:messagebird, :credentials)
	
	def valide_phonenumber?(number), do: do_request(:get, url(:lookup, number)) |> Poison.decode! |> handle_response
	
	def send_sms(%{message: message, recipient: recipient, reference: reference, originator: originator}), do: do_request(:post, url(:sms) , body(originator,reference, message, [recipient])) |> handle_response
	
	def url(:lookup, value), do: "#{@api_base_url}/lookup/#{value}"
	def url(:sms), do: "#{@api_base_url}/messages"
	
	def header(), do: [{"Authorization", "AccessKey #{@config[:token]}"}]

	def body(originator,reference, body, recipients), do: %{originator: originator, reference: reference, body: body, recipients: recipients} |>  Poison.encode!
	
	def do_request(:get, url), do: HTTPoison.get!(url, header()) |> Map.get(:body)
	def do_request(:post, url, body), do: HTTPoison.post!(url, body, header())
	
	def handle_response(%{"items" => %{"recipient" => [%{"status" => "sent"}]}}), do: true
	def handle_response(%{"errors" => [%{"code" => code}]}), do: false 
	def handle_response(%{"countryCode" => country_code, "formats" => %{"international" => format}, "type" => type}), do: true
	def handle_response(_), do: false
end