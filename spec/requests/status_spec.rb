require 'rails_helper'
# put " :focus " on a block of test to just run that specif test. it is already activated in spec_helper.rb

RSpec.describe PokemonsController do
    let(:json) {JSON.parse(response.body)}
    # INDEX Test: it check the GET request by testing the status and also filteration based on the Type1 attribute.
    describe 'GET / pokemons' do
        before do 
            Pokemon.create(Name: "Volcanion", Type1: "Fire", Type2: "Water")
            Pokemon.create(Name: "Tirause",Type1: "Fire", Type2: "Grass")
            Pokemon.create(Name: "Jalupinion",Type1: "Fire", Type2: "Grass")
        end
        it ' returns a status message' do 
            get('/pokemons')
            expect(json['status']).to eq('SUCCESS')
            expect(response).to have_http_status(:success)
        end
        it 'returns 3 pokemon of Type1 = Fire' do
            headers = {'ACCEPT' => 'applicaiton/json'}
            get '/pokemons', :params =>{:Type1 => 'Fire'}, :headers => headers
            p "Total available pokemons: #{json['total']}"
            expect(json['data'].size).to eq(3)
        end
    end

    # CREATE Test: it tests the pokemon creation by checking json status
    describe 'POST / pokemons'  do 
        it 'confirm creation of a new pokemon' do 
            post('/pokemons')
            if json['status'] == 'SUCCESS'
                expect(json['message']).to eq('Pokemon created')
            else
                p json['status']
                expect(json['message']).to eq('Pokemon not created')
            end
        end
        it 'creates a new Pokemon' do 
            headers = {"ACCEPT" => "application/json"}
            post '/pokemons', :params =>{:Name => 'Almaraus'}, :headers => headers
            expect(Pokemon.count).to eq(1)
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