# README


# PetalMD - Pokemons REST API


## CRUD functions
 That is how you may use each of the CRUD reqeusts:
* GET Request:
* * /pokemons

    :list of all the pokemons table
    
    /pokemons/#id   :details of pokemon with this id

* POST
* * /pokemons


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
* * /pokemons/#id 

        to update a pokemon's profile you need to configure the header of the request:
            key: Content-Type / value: application/json        
        Then add the new parameter(s) in the body of the request in a json format
* DELET
* * /pokemons/#id 

        will delet the mentiond pokemon's profile
        
----------------
## TEST DERIVEN DEVELOPMENT 
 The controller is tried to be developed based on unit testing using RSPEC.
 you may find the test file at

 ./spec/requests/status_spec.rb

 ------------------
