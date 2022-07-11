class GameController < ApplicationController


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

  	data = JSON.parse(params[:data])

  	game = Game.new(generation, rows, columns, data, @speed)
  	Rails.cache.write('game-status', 'running')

    @out = game.execute

  end

end
