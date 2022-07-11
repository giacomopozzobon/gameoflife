class Game

	attr_accessor :generation, :rows, :columns, :data, :speed, :grid

	def initialize(generation, rows, columns, data, speed)
		@generation = generation.to_i
		@rows = rows.to_i
		@columns = columns.to_i
		@data = data
		@speed = speed.to_f
	end

	def execute
		
		#initial empty grid
		@grid = Array.new(@rows){Array.new(@columns) { 0 }}

		#Game Algorithm

		# if (cell.has_alive_neighbours(3) || (cell.is_alive && cell.has_alive_neighbours(2)) -> Alive
		# else -> DIE

		@data.each_with_index do |row, row_index|
			row.each_with_index do |cell, cell_index|
				
				#Evolve Cell
				if (has_alive_neighbours(row_index, cell_index, 3) || (is_alive(row_index, cell_index) && has_alive_neighbours(row_index, cell_index, 2)))
					value = 1
				else
					value = 0
				end

				#Set New Value
				@grid[row_index][cell_index] = value

			end
		end

		#Check if the Grid Continue or End
		status = Rails.cache.read('game-status')

		if @data.sort == @grid.sort
			status = 'stop'
		end

		if @generation > 30
			status = 'stop'
		end

		puts "[GAME STATUS] #{status}"
		puts "[GENERATION] #{generation}"

		if status == 'running'
			grid_continue
		else
			{ generation: @generation, data: @grid }
		end

	end

	#Check if a Cell is Dead or Alive
	def is_alive(row_index, cell_index)
		res = false

		if (@data.kind_of?(Array) && @data[row_index].kind_of?(Array))

			if @data[row_index][cell_index] == 1
				res = true
			end
		end
		return res
		
	end

	#Check if a Cell has n Alive Neighbours
	def has_alive_neighbours(row_index, cell_index, n)
		alive_neighbours = 0

		for offset_x in -1..1 do
  			for offset_y in -1..1 do
  				#Check if not Cell Self
  				if !(offset_x == 0 && offset_y == 0)
  					if is_alive(row_index+offset_x, cell_index+offset_y)
  						alive_neighbours += 1
  					end			
  				end
			end
		end

		if alive_neighbours.to_i == n.to_i
			res = true
		else
			res = false
		end

		return res
	end

	#Repeat Algorithm
	def grid_continue
		
		@generation += 1

		#Print Grid
		##puts "Generation: "+@gen.to_s
        ##print @new_grid.map{|row| row.join(" ")}.join("\n")

		print_grid

		@data = @grid

		repeat_execute

	end

	# Re-Launch Execute
	def repeat_execute
        sleep @speed*2
        execute
    end

	#Print Grid in the View
	def print_grid
		
		#table = '<table style="border-collapse: collapse;">'
		table = ''
		@grid.each do |row|
			table += '<tr>'
			row.each do |cell|
				table += '<td class="'
					if cell == 0
						table += 'bg-light'
					else
						table += 'bg-dark'
					end
				table += '" style="width: 20px; height: 20px; border: 1px solid black;"></td>'
			end
			table += '</tr>'
		end
		#table += '</table>'

		ActionCable.server.broadcast(
		"grid_channel",
		{
			generation: @generation,
			grid: table
		})
	end
end