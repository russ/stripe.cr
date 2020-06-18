class Stripe::Token
  def self.retrieve(id : String) : Token
    response = Stripe.client.get("/v1/tokens/#{id}")

    if response.status_code == 200
      Token.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end

  def self.retrieve(token : Token)
    retrieve(token.id)
  end
end
