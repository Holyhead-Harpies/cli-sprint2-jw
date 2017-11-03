require 'sqlite3'

class CustomerModel

	def initialize
		@db = SQLite3::Database.open('./db/sprint2.sqlite')
		@db.results_as_hash=true
	end

	def get_all_customers
		stm = @db.execute "select * from Customers"
	end



end
