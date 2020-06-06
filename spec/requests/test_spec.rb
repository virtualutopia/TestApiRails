require 'rails_helper'
# put " :focus " on a block of test to just run that specif test. it is already activated in spec_helper.rb

RSpec.describe Api::V1::TestController do
    let(:json) {JSON.parse(response.body)}
    describe 'GET/Test' do 
        it ' returns a status message' do 
            get('/api//v1/test')
            expect(json['status']).to eq('SUCCESS')
            expect(response).to have_http_status(:success)
        end
    end
end