require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  before :each do
    @garden = Garden.create!(name: "Schmiddy's Botanicals", organic: true)
    @plot1 = @garden.plots.create!(number: 42, size: 'Large', direction: 'Northeast')
    @plot2 = @garden.plots.create!(number: 87, size: 'Medium', direction: 'Southwest')
    @plot3 = @garden.plots.create!(number: 11, size: 'Small', direction: 'South')
    @plant1 = @plot1.plants.create!(name: 'kale', description: 'green', days_to_harvest: 30)
    @plant2 = @plot1.plants.create!(name: 'tomato', description: 'red', days_to_harvest: 20)
    @plant3 = @plot2.plants.create!(name: 'pepper', description: 'yellow', days_to_harvest: 10)
    @plant4 = Plant.create!(name: 'lily', description: 'flower', days_to_harvest: 50)
    @plant5 = @plot2.plants.create!(name: 'tomatillo', description: 'yellow', days_to_harvest: 100)
    PlantPlot.create!(plant: @plant2, plot: @plot1)
    PlantPlot.create!(plant: @plant2, plot: @plot3)
    PlantPlot.create!(plant: @plant3, plot: @plot3)
  end

  it 'gets distinct plants for a garden' do
    expect(@garden.plants[0].name).to eq(@plant2.name)
    expect(@garden.plants[1].name).to eq(@plant3.name)
    expect(@garden.plants[2].name).to eq(@plant1.name)
    expect(@garden.plants[3]).to eq(nil)
  end
end
