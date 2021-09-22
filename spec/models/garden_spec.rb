require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  before :each do
    @garden = Garden.create!(name: "Schmiddy's Botanicals", organic: true)
    @plot1 = @garden.plots.create!(number: 42, size: 'Large', direction: 'Northeast')
    @plot2 = @garden.plots.create!(number: 87, size: 'Medium', direction: 'Southwest')
    @plant1 = @plot1.plants.create!(name: 'kale', description: 'green', days_to_harvest: 30)
    @plant2 = @plot1.plants.create!(name: 'tomato', description: 'red', days_to_harvest: 20)
    @plant3 = @plot2.plants.create!(name: 'pepper', description: 'yellow', days_to_harvest: 10)
    @plant4 = Plant.create!(name: 'lily', description: 'flower', days_to_harvest: 150)
    @plant5 = @plot2.plants.create!(name: 'tomatillo', description: 'yellow', days_to_harvest: 100)
    PlantPlot.create!(plant: @plant1, plot: @plot2)
  end

  it 'gets distinct plants for a garden' do
    expect(@garden.plants.count).to eq(3)
    expect(@garden.plants[0].name).to eq(@plant1.name)
    expect(@garden.plants[1].name).to eq(@plant3.name)
    expect(@garden.plants[2].name).to eq(@plant2.name)
  end
end
