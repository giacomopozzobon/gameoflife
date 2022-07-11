class Validator

	attr_accessor :file

	def initialize(file)
		@file = file.to_s
	end

	#Validate Input File
	def validate
		
		generation = 0
		columns = 0
		rows = 0
		data = Array.new
		
		isvalid = false
		message = 'File uploaded with success'

		rows_check = 0

		#Check if file is like the example
		File.foreach(file).with_index do |line, i|

			#First Line: es. 'Generation 3:'
			if i == 0
				regex = Regexp.new('^Generation [0-9]+:$', )

				if regex.match?(line.strip)
					isvalid = true
					generation = line.scan(/\d+/)[0]
				else
					isvalid = false
					message = 'First Line: the first line doesn\'t corrispond to  es. \'Generation 3:\'. Please specify the number of the Generation.'
					break
				end
			end

			#Second Line: es. 4 8
			if i == 1
				regex = Regexp.new('^[0-9]+ [0-9]+$', )

				if regex.match?(line.strip)
					isvalid = true
					rows = line.scan(/\d+/)[0]
	                columns = line.scan(/\d+/)[1]
				else
					isvalid = false
					message = 'Second Line: the second line doesn\'t corrispond to  es. 4 8. Please specify Rows and Columns.'
					break
				end
			end

			#Grid Lines: es. .... ..*. .**. .... ....
			if i > 1
				rows_check += 1
				regex = Regexp.new('^[.*]*$', )

				#Check if the number of columns specified corresponds to the grid line
				if regex.match?(line.strip) && line.strip.length.to_i == columns.to_i
					isvalid = true
					data.push(line.strip.gsub(".","0").gsub("*","1").split(//).map(&:to_i))				
				else
					isvalid = false
					message = i + ' Line: Number of columns not corrisponding OR symbol not allowed. Please use only . or * to specify if a cell is Dead or Alive.'
					break
				end
			end
		end

		#Check if the number of rows specified corresponds to the grid
		if rows_check.to_i != rows.to_i && isvalid
			isvalid = false
			message = "Number of rows not corrisponding"
		end

		return  {generation: generation, rows: rows, columns: columns, data: data, valid: isvalid, message: message}
	end
end