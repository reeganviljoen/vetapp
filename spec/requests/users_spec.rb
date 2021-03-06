require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'POST /signup' do

    let(:user) {build(:user, role:'owner')}
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_attributes) { attributes_for(:user, password_confirmation: user.password, role: user.role) }
    context 'when the request is valid' do

      before { post '/signup', params:valid_attributes.to_json, headers: headers}
      
      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns a token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when the request is invalid' do
      before { post '/signup', params:{}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(json['message']).to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end 
  end
end