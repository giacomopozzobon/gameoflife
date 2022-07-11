class GameController < ApplicationController

  $end = {}

  def index
    @game = session[:game]
  end

  # manage Start Game
  def start

  	require 'json'

  	generation = params[:generation]
  	rows = params[:rows]
  	columns = params[:columns]
  	@speed = params[:speed].to_f
    @stop_after = params[:stop_after]

  	data = JSON.parse(params[:data])

  	game = Game.new(generation, rows, columns, data, @speed, @stop_after)
  	Rails.cache.write('game-status', 'running')

    @out = game.execute

    #save for redirect
    $end = @out

    redirect_to end_path, notice: "Simulation Ended"

  end

  #manage end game
  def end
    @out = $end
  end

end
