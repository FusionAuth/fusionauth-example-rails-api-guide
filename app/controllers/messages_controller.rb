class MessagesController < ApplicationController
  def index
    messages = []
    messages << "Hello"

    # further claims/authorization checks
    roles = request.env['jwt.payload']['roles']
    if roles.include?('ceo') 
      messages << "Hiya, boss"
    end
    render json: { messages: messages }.to_json, status: :ok
  end
end

