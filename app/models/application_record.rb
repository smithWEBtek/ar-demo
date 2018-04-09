class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
	
	def self.my_methods
		puts self.methods.sort
		puts 'Total number of Class methods: ' + self.methods.count.to_s
	end
	
	def my_methods
		puts self.methods.sort
		puts 'Total number of instance methods: ' + self.methods.count.to_s
	end

end