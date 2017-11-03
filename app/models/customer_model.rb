require 'sqlite3'
class CustomerModel
	def initialize
		@db = SQLite3::Database.open('./db/sprint2.sqlite')
		@db.results_as_hash=true
	end
	def select_customer(customer)
		stm = @db.execute "select * from Customers where CustomerId = #{customer}"
		if stm == []
			'Customer Does Not Exist'
		else
			stm[0]['CustomerId']
		end
	end


end