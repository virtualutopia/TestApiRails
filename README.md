# README


# PetalMD - Pokemons REST API


## CRUD functions
    
 That is how you may use each of the CRUD reqeusts:
* GET 
* * http://35.182.117.245/pokemons
        
        :list of all the pokemons table
        /pokemons/#id   :details of pokemon with this id

* POST
* * http://35.182.117.245/pokemons


        to add a new pokemon to the list one need to configure the header of the request:
            key: Content-Type / value: application/json
        put the pokemon's details in the "body" of the requst as a raw/json like:
        {        
            "Name": "thiranosaurus",
            "Type1": "Grass",
            "Type2": "Poison",
            "Total": 318,
            "HP": 45,
            "Attack": 49,
            "Defense": 49,
            "SpDef": 65,
            "Speed": 65,
            "Generation": 45,
            "Legendary": true
        }
* PUT/PATCH
* * http://35.182.117.245/pokemons/#id 

        to update a pokemon's profile you need to configure the header of the request:
            key: Content-Type / value: application/json        
        Then add the new parameter(s) in the body of the request in a json format
* DELET
* * http://35.182.117.245/pokemons/#id 

        to delete the mentiond pokemon's profile
        
* Paginated response
* * http://35.182.117.245/lists

        by defult it returns a list of 5 pokemon profile per page.
        However, it is possible to change the offset and limit of the pagination, directly on the endpoint address. for example
        http://35.182.117.245/lists?page=3&perPage=2
        shows page 3 of the results in which there are 2 profiles.
        
        there is an option of filter out the responses based on pokemon's Type1 or Type2 attributes.
        include your desired Type in a json format in the body of header of the request and you will recieve the results corresponding to that Type:
        for example: 
                Header-body > 
                        {"Type1": "Grass"}
                returns:
                {
                "status": "SUCCESS",
                "message": "Pokemon list printed",
                "total": 72,
                "data": [
                        {
                        "id": 1,
                        "Name": "Bulbasaur",
                        "Type1": "Grass",
                        "Type2": "Poison",
                        ...
                        }

----------------
## TEST DERIVEN DEVELOPMENT 
 The controller is tried to be developed based on unit testing using RSPEC.
 here is the test file:
 ./spec/requests/status_spec.rb

 There is also a small test on Pokemon Model to check the validation of data:
 ./spec/requests/pokemon_model_spec.rb

 ------------------
