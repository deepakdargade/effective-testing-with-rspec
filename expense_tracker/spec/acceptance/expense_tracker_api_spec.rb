require 'rack/test'
require 'json'
require_relative '../../app/api'

def app
	ExpenseTracker::API.new
end

module ExpenseTracker
	RSpec.describe 'Expense Tracker API' do
		include Rack::Test::Methods

		def post_expense(expense)
			post '/expenses', JSON.generate(expense)
			expect(last_response.status).to eq(200)

			parsed_data = JSON.parse(last_response.body)
			expect(parsed_data).to include('expense_id' => a_kind_of(Integer))
			expense.merge('id' => parsed_data['expense_id'])
		end


		it 'records submitted expenses' do
			pending 'Need to persist the expenses'

			coffee = post_expense(
				'payee' => 'Starbucks',
				'amount' => 5.75,
				'date' => '2022-03-10'
			)

			zoo = post_expense(
				'payee' => 'Zoo',
				'amount' => 15.25,
				'date' => '2022-03-11'
			)

			groceries = post_expense(
				'payee' => 'Whole Foods',
				'amount' => 95.20,
				'date' => '2022-03-11'
			)

			get '/expenses/2022-03-11'
			expect(last_response.status).to eq(200)

			expenses = JSON.parse(last_response.body)
			expect(expenses).to contain_exactly(zoo, groceries)
		end
	end
end