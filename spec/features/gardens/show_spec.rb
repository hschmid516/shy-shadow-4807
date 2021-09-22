require 'rails_helper'

RSpec.describe 'gardens show' do
  before :each do
    @garden = Garden.create!(name: "Schmiddy's Botanicals", organic: true)
    @plot1 = @garden.plots.create!(number: 42, size: 'Large', direction: 'Northeast')
    @plot2 = @garden.plots.create!(number: 87, size: 'Medium', direction: 'Southwest')
    @plant1 = @plot1.plants.create!(name: 'kale', description: 'green', days_to_harvest: 30)
    @plant2 = @plot1.plants.create!(name: 'tomato', description: 'red', days_to_harvest: 20)
    @plant3 = @plot2.plants.create!(name: 'pepper', description: 'yellow', days_to_harvest: 10)
    @plant4 = Plant.create!(name: 'lily', description: 'flower', days_to_harvest: 50)
    PlantPlot.create!(plant: @plant1, plot: @plot2)
    visit garden_path(@garden)
  end

  it 'shows list of plants included in gardens plots' do
    expect(page).to have_content(@plant1.name, count: 1)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)
    expect(page).to_not have_content(@plant4.name)
  end
end
