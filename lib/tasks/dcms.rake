namespace :db do 
	desc 'drop, create, migrate, seed and start rails'
	task dcms: :environment do
		puts 'dropping the database ...'
		Rake::Task['db:drop'].invoke

		puts 'create database ...'
		Rake::Task['db:create'].invoke

		puts 'migrate database ...'
		Rake::Task['db:migrate'].invoke

		puts 'seed database ...'
		Rake::Task['db:seed'].invoke

		puts 'start rails server ...'
		exec('rails s')
	end
end