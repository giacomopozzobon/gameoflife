class HomeController < ApplicationController
  
	def index
  	end

  	# manage Input File / Validate File
  	def upload

  		file = Validator.new(params[:input_file].path)
  		@game = file.validate

  		session[:game] = @game
    	redirect_to game_path, notice: @game[:message]
  	end

end
