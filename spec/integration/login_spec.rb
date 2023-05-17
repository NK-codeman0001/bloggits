# require 'swagger_helper'

# describe 'REST API Documentation of Bloggit - Login' do
#   path '/users/login' do
#     post 'Log in' do
#       tags 'Authentication'
#       consumes 'application/json'
#       produces 'application/json'
#       parameter name: :login_params, in: :body, schema: {
#         type: :object,
#         properties: {
#           user: {
#             type: :object,
#             properties: {
#               username: { type: :string },
#               password: { type: :string }
#             },
#             required: %w[username password]
#           }
#         },
#         required: %w[user]
#       }

#       response '200', 'User successfully logged in' do
#         let(:user) { create(:user) }
#         let(:login_params) do
#           {
#             user: {
#               username: user.username,
#               password: 'password'
#             }
#           }
#         end

#         before do |example|
#           # Fetch CSRF token dynamically
#           csrf_token = get_csrf_token

#           # Include CSRF token in the request headers
#           header 'X-CSRF-Token', csrf_token

#           # Set the request content type
#           header 'Content-Type', 'application/json'

#           # Skip CSRF token verification for this example
#           ApplicationController.allow_forgery_protection = false

#           submit_request(example.metadata)
#         end

#         run_test! do
#           expect(response).to have_http_status(200)
#         end
#       end

#       # Rest of the code...
#     end
#   end
# end

# def get_csrf_token
#   # Make a request to fetch the CSRF token from your application's backend
#   # Replace the following code with the appropriate implementation for your application
#   response = Net::HTTP.get_response(URI('http://localhost:3000/get_csrf_token'))
#   csrf_token = response['X-CSRF-Token'] if response.is_a?(Net::HTTPSuccess)
#   csrf_token || 'default_csrf_token'
# end
