RSpec.configure do |config|
	config.filter_run_when_matching(focus: true)
	config.example_status_persistence_file_path = 'spec/example.txt'
end

class Coffee
	def ingredients
		@ingredients ||= []
	end

	def add(ingredient)
		ingredients << ingredient
	end

	def price
		1.00 + ingredients.size * 0.25
	end

	def color
		ingredients.include?(:milk) ? :light : :dark
	end

	def temperature
		ingredients.include?(:milk) ? 80 : 100
	end
end

RSpec.describe 'A cup of coffee' do

	let(:coffee) { Coffee.new }

	it 'costs 1$' do
		expect(coffee.price).to eq(1.00)
	end

	# context 'with milk', focus: true do
	# fcontext 'with milk' do
	context 'with milk' do
		before { coffee.add :milk }

		it 'costs 1.25$' do
			expect(coffee.price).to eq(1.25)
		end

		it 'is lighter in color' do
			# pending('color not implemented yet')
			expect(coffee.color).to eq(:light)
		end
			
		it 'is cooler than 100 degree celcius' do
			# pending('temperature not implemented yet')
			expect(coffee.temperature).to be < 100.0
		end
	end
end