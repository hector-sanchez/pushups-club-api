require 'rails_helper'

RSpec.describe 'Clubs api', type: :request do
	let!(:clubs) { FactoryGirl.create_list(:club, 10) }
	let(:club_id) { clubs.first.id }

	describe 'GET /clubs' do
		before { get '/clubs' }

		it 'returns clubs' do
			# json is a custom helper to parse JSON requests
			expect(json).not_to be_empty
			expect(json.size).to eq 10
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /clubs/:id' do
		before { get "/clubs/#{club_id}" }

		context 'when the record exists' do
			it 'returns the club' do
				expect(json).to_not be_empty
				expect(json['id']).to eq club_id
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:club_id) { 100 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do
				expect(response.body).to match(/Couldn't find club/i)
			end
		end
	end

	describe 'POST /clubs' do
		let(:valid_attributes) { 
			{name: 'Killers', created_by: 'strong_man'}
		}

		context 'when the request is valid' do
			before { post '/clubs', params: valid_attributes }

			it 'creates a club' do
				expect(json['name']).to eq 'Killers'
			end

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do
			before { post '/clubs', params: {name: 'Killers'} }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
		end
	end

	describe 'PUT /clubs/:id' do
    let(:valid_attributes) { { name: 'Killers' } }

    context 'when the record exists' do
      before { put "/clubs/#{club_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /clubs/:id' do
    before { delete "/clubs/#{club_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end