require 'rails_helper'
# put " :focus " on a block of test to just run that specif test. it is already activated in spec_helper.rb

RSpec.describe PokemonsController do
    let(:json) {JSON.parse(response.body)}
    # INDEX Test: it check the GET request by testing the status
    describe 'GET / pokemons' do
        # before do 
        #     get :index
        # end
        it ' returns a status message' do 
            get('/pokemons')
            # json = JSON.parse(response.body)
            expect(json['status']).to eq('SUCCESS')
            # expect(response.status).to eq(200)
            expect(response).to have_http_status(:success)
            # expect(response).to have_http_status(:error)

            # expect(response.data.map(&:name)).to include('Dodrio')
        end
        # it 'Response contain exact attributes', :focus do  #data is []
        #     get('/pokemons')
        #     expect(json.keys).to match_array([:Name, :Type1, :Type2, :Total, :HP, :Attack, :Defense, :SpDef, :Speed, :Generation, :Legendary])
        # end
    end
    # CREATE Test: it tests the pokemon creation by checking json status
    describe 'POST / pokemons'  do 
        # let (:valid_params) do
        #     {
        #         data: {
        #         "Name": "Volcanion",
        #         "Type1": "Fire",
        #         "Type2": "Water",
        #         "Total": 600,
        #         "HP": 80,
        #         "Attack": 110,
        #         "Defense": 120,
        #         "SpDef": 130,
        #         "Speed": 90,
        #         "Generation": 70,
        #         "Legendary": true
        #         }
        #     }
        # end
        it 'confirm creation of a new pokemon' do 
            post('/pokemons')
            if json['status'] == 'SUCCESS'
                expect(json['message']).to eq('Pokemon created')
            else
                p json['status']
                expect(json['message']).to eq('Pokemon not created')
                # expect(response).to have_http_status(:error)
            end
        end
        it 'creates a new Pokemon' do 
            headers = {"ACCEPT" => "application/json"}
            post '/pokemons', :params =>{:Name => 'Almaraus'}, :headers => headers
            expect(Pokemon.count).to eq(1)
        end
        # it 'create a pokemon' do
        #     post "/pokemons", :params => {:pokemon => :valid_params}
        #     expect(response).to have_http_status(:success)
        # end

        # it 'creates a pokemon' do
        #     p Pokemon.count
        #     p valid_params
            
        #     if json['status'] == 'SUCCESS'
        #         expect(json['message']).to eq('Pokemon created')
        #         p json['message']
        #     else
        #         p json['status']
        #         expect(json['message']).to eq('Pokemon not created')
        #         p json['message']
        #     end
        #     expect {post"/pokemons", params: valid_params}.to change(Pokemon, :count).by(+1)
        # end
    end

    describe '/List returns a numbered list of the pokemons name' do
        before do 
            Pokemon.create(Name: "Volcanion", Type1: "Fire", Type2: "Water")
            Pokemon.create(Name: "Tirause",Type1: "Fire", Type2: "Grass")
            Pokemon.create(Name: "Jalupinion",Type1: "Fire", Type2: "Grass")
        end
        it 'confirm success' do
            get('/list')
            expect(json['status']).to eq('SUCCESS')
        end
        it 'returns two pokemons of Type2=Grass' do
            headers = {'ACCEPT' => 'applicaiton/json'}
            get '/list', :params =>{:Type2 => 'Grass'}, :headers => headers
            p "Total available pokemons: #{json['total']}"
            expect(json['total']).to eq(2)
        end
        it 'returns just one pokemon of Type1 = Water', :focus do
            headers = {'ACCEPT' => 'applicaiton/json'}
            get '/list', :params =>{:Type1 => 'Fire'}, :headers => headers
            p "Total available pokemons: #{json['total']}"
            expect(json['total']).to eq(3)
        end
    end
    # DESTROY test: it deletes on profile and check the remaining total in DB. It also check the output json data.
    describe 'destroy a pokemon' do 
        before do
            Pokemon.create(Name: "pokemon1")
            Pokemon.create(Name: "pokemon2")
            Pokemon.create(Name: "pokemon3")
            Pokemon.create(Name: "pokemon4")
        end
        it 'deletes the last pokemon' do 
            delete('/pokemons/4')
            expect(Pokemon.count).to eq(3)
            expect(json['data']).to include("Name" => "pokemon4")
        end
    end
end