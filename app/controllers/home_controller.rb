class HomeController < ApplicationController
  @@lines = Array.new

  def index
  end

  def game
      @lines = @@lines
  end

  def uploadfile
    if params[:file].present?
      
      filename = params[:file]

      if filename.respond_to?(:read)
        @@lines = filename.read.split("\r\n")
      elsif filename.respond_to?(:path)
        @@lines = File.read(filename.path).split("\r\n")
      else
        logger.error "Bad file_data: #{filename.class.name}: #    
        {@filename.inspect}"
      end

      redirect_to home_game_path

    end
  end

end
