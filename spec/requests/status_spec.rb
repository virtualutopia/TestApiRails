require 'rails_helper'

RSpec.describe 'Status requests' do
    let(:json) {JSON.parse(response.body)}
    describe 'GET / pokemons' do
        it ' returns a status message' do 
            get('/pokemons')
            # json = JSON.parse(response.body)
            expect(json['status']).to eq('SUCCESS')
            expect(response.status).to eq(200)
            

            # expect(response.data.map(&:name)).to include('Dodrio')
        end
        # it ' check a pokemon name to be in the result' do 
        #     get('/pokemons')
        #     expect(json['data'][0]["Name"]).to include('Bulbasaur')
        # end
    end
    describe 'POST / pokemons' do 
        it 'confirm creation of a new pokemon' do 
            post('/pokemons')
            if json['status'] == 'SUCCESS'
                expect(json['message']).to eq('Pokemon created')
            else
                p json['status']
                expect(json['message']).to eq('Pokemon not created')
            end
        end
    end

end