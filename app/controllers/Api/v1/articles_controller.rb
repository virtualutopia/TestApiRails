require 'pry-byebug'
# binding.pry{}
# module Api
    # module V1
        class ArticlesController < ApplicationController
            def index
                articles = Articel.order('created_at DESC');
                render json: {status: 'SUCCESS', message:'Articles loaded', data:articles}, status: :ok
            end

            def show

            end
            
            def create
            end
            
            def update
            end

            def destroy
            end

        end
    # end
# end