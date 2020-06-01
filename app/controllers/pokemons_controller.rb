# REST API Controller
class PokemonsController < ApplicationController
    # /pokemons
    def index
        pokemonPerPage = params.fetch(:limit, 10).to_i
        offsetValue = params.fetch(:offset, 0).to_i
        # Filtering based on Type1 attribute, if presente?
        if params[:Type1].present?  
            pokemonsOfType = Pokemon.where(Type1: params[:Type1])
            paginatedPokemon = pokemonsOfType.offset(offsetValue).limit(pokemonPerPage)
            total = pokemonsOfType.count         
            loaded = paginatedPokemon.count
            render json: {status: 'SUCCESS', message:"#{loaded} Pokemons loaded out of #{total}", data: paginatedPokemon}, status: :ok
        # List all pokemons
        else
            pokemons = Pokemon.offset(offsetValue).limit(pokemonPerPage)
            loaded = pokemons.count
            total = Pokemon.all.count
            render json: {status: 'SUCCESS', message:"#{loaded} Pokemons loaded out of #{total}", data: pokemons}, status: :ok
        end
    end

    # /pokemons/#id
    def show
        pokemon = Pokemon.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Pokemon loaded', data: pokemon}, status: :ok
    end

    # /pokemons
    def create
        pokemon = Pokemon.new(pokemon_params)
        # Throw an error if this Name is already available in the list
        if alreadyExist
            error = "this pokemon already exist"
            render json: {status: 'FAIL', message: 'Pokemon not created', data: '', error: error}, status: :bad_request
        elsif pokemon.save
            render json: {status: 'SUCCESS', message: 'Pokemon created', data: pokemon}, status: :created
        else
            # Name attribure must provided. there is a specif error massage for this error 
            if !params[:Name]
                error = "Name can't be blank"
            else
                error = "check the input structure"
            end
            render json: {status: 'FAIL', message: 'Pokemon not created', data: '', error: error}, status: :bad_request
        end
    end

    # /pokemons/#id
    def destroy
        pokemon = Pokemon.find(params[:id])
        pokemon.destroy
        render json: {status: 'SUCCESS', message: 'Pokemon deleted', data: pokemon}, status: :ok
    end

    # /pokemons/#id
    def update
        pokemon = Pokemon.find(params[:id])
        if pokemon.update_attributes(pokemon_params)
            render json: {status: 'SUCCESS', message: 'Pokemon updated', data: pokemon}, status: :ok
        else
            render json: {status: 'FAIL', message: 'Pokemon not updated', data: pokemon.errors}, status: :unprocessable_entity
        end
    end

    private
    def pokemon_params
        params.permit(:Name, :Type1, :Type2, :Total, :HP, :Attack, :Defense, :SpDef, :Speed, :Generation, :Legendary)
    end
    def alreadyExist
        pokemons = Pokemon.all
        pokemons.each do |pok|
            if pok['Name'].to_s == params[:Name].to_s
                return true
            end
        end
        false
    end
end
