# README
 
 
# PetalMD - Pokemons REST API
 
 
## CRUD functions
  
That is how you may use each of the CRUD requests:
* GET
      
       http://35.182.117.245/pokemons
       :list of all the pokemons table
       /pokemons/#id   :details of pokemon with this id
 
* POST

       http://35.182.117.245/pokemons
       to add a new pokemon to the list put json of the new pokemon profile in the "body" of the request and set `Content-Type` header as `application/json`, example:
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
 
       http://35.182.117.245/pokemons/#id
       to update a pokemon's profile put json of changes in the "body" of the request and set `Content-Type` header as `application/json`.
* DELET
      
       http://35.182.117.245/pokemons/#id
       to delete the mentioned pokemon's profile
#
* response body structure
       
       It consists of four parts
       - status
       - message
       - data
       - error (Just in case of having error)

* Paginated response
      
       http://35.182.117.245/pokemons
       By default it returns a list of 10 pokemon profiles per page (limit = 10), starting from pokemon ID = 1 (offset = 0).
       However, it is possible to change the offset and limit of the pagination, directly on the endpoint address. for example
       http://35.182.117.245/pokemons?offset=100&limit=20 
       which returns 20 profiles, starting from ID = 101.
      
       There is an option to filter out the responses based on pokemon's Type1 attributes by including "Type1" and its value in the URI. for example:
        http://35.182.117.245/pokemons?Type1=Water
        returns all the profils with a Type1 value of "Water" in a default pagination format.
 
        another example of including both pagination formatting and filtering:
        http://35.182.117.245/pokemons?offset=10&limit=10&Type1=Grass


----------------
## TEST DRIVEN DEVELOPMENT
The controller is developed and refactored based on implementing unit tests using RSPEC.
here is the test file:
./spec/requests/status_spec.rb
 
There is also a small test on Pokemon Model to check the validation of data:
./spec/requests/pokemon_model_spec.rb

 To run the test you need to clone the code from GitHub repositiory and run the following test on your local.
 - pokemons controller test

        bundle exec rspec spec/requests/status_spec.rb --format documentation
- Pokemon Model test
        - bundle exec rspec spec/requests/pokemon_model_spec.rb --format documentation

------------------
 
# # Way to go
There are other considerations needs to be applied. But I ignore it for the moment due to lack of time and also some technical issues with my old laptop. Here I mention some of them:
- SSL 

         It is neccessary for the security reason to activate https port and communicate through it. I can do that via server firewall setting or by using services like [CloudFlare](https://www.cloudflare.com/).
         https://www.cloudflare.com 
         
- More unit tests

       Add more tests on each request block to cover all possible origin of errors

- Validite all pokemons attribute

       Validate inputs structure/type in the Pokemon.rb, at least for "legend" which must to be a false/true.

- User Authentication
        
        It would be more secure to add a authentication procedure to limit the access to the API

- Employ more gems

        Gems provide more option and somethimes less coding how ever i tried to keep it simple. for example it is also possible to handle the pagination using "kaminari" gem.

- Auto Deploy

        for the moment the app needs to be deployed manually after each push on github. however it is possible to activate an automated deployment using webhooks.
