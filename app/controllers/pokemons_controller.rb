
class PokemonsController < ApplicationController
    def index
        pokemons = Pokemon.order('id DESC');
        render json: {status: 'SUCCESS', message:'Pokemons loaded', data: pokemons}, status: :ok
    end

    def show
        pokemon = Pokemon.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Pokemon loaded', data: pokemon}, status: :ok
    end

    def create
        pokemon = Pokemon.new(pokemon_params)
        if pokemon.save
            render json: {status: 'SUCCESS', message: 'Pokemon created', data: pokemon}, status: :ok
        else
            render json: {status: 'FAIL', message: 'Pokemon not created', data: pokemon.errors}, status: :unprocessable_entity
        end
    end

    def destroy
        pokemon = Pokemon.find(params[:id])
        pokemon.destroy
        render json: {status: 'SUCCESS', message: 'Pokemon deleted', data: pokemon}, status: :ok
    end

    def update
        pokemon = Pokemon.find(params[:id])
        if pokemon.update_attributes(pokemon_params)
            render json: {status: 'SUCCESS', message: 'Pokemon updated', data: pokemon}, status: :ok
        else
            render json: {status: 'FAIL', message: 'Pokemon not updated', data: pokemon.errors}, status: :unprocessable_entity
        end
    end

    def list
        render json: {status: 'SUCCESS', message: 'Pokemon list printed'}, status: :ok
    end

    private
    def pokemon_params
        params.permit(:Name, :Type1, :Type2, :Total, :HP, :Attack, :Defense, :SpDef, :Speed, :Generation, :Legendary)
    end
end
