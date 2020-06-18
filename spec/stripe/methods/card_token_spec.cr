require "../../spec_helper"

describe Stripe::Token do
  it "create card token" do
    WebMock.stub(:post, "https://api.stripe.com/v1/tokens")
      .to_return(status: 200, body: File.read("spec/support/create_card_token.json"), headers: {"Content-Type" => "application/json"})

    token = Stripe::Token.create(card: {
      number:    "4242424242424242",
      exp_month: 12,
      exp_year:  2019,
      cvc:       123,
    })

    token.id.should eq("tok_103eog2eZvKYlo2CE8etNomD")
  end

  it "retreive card token" do
    token = "tok_1GvPtCJfypbUNZOgWpTXj98n"
    WebMock.stub(:get, "https://api.stripe.com/v1/tokens/#{token}")
      .to_return(status: 200, body: File.read("spec/support/retreive_card_token.json"), headers: {"Content-Type" => "application/json"})

    token = Stripe::Token.retrieve(token)
    token.card.not_nil!.id.should eq("card_1GvPtCJfypbUNZOgsz6OIKuT")
  end
end
