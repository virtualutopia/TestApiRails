module Api
    module V1
        class TestController < ApplicationController
            def index
                tests = Pokemon.all
                render json: {status: 'SUCCESS', message:" Test loaded out of", data: tests}, status: :ok
            end
        end
    end
end