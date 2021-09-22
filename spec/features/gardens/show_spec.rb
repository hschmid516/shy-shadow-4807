require 'rails_helper'

RSpec.describe 'gardens show' do
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
    visit garden_path(@garden)
  end

  it 'shows list of plants included in gardens plots < 100 days to harvest' do
    expect(page).to have_content(@plant1.name, count: 1)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)
    expect(page).to_not have_content(@plant4.name)
    expect(page).to_not have_content(@plant4.name)
  end

  it 'shows plants sorted from most to least' do
    expect(@plant2.name).to appear_before(@plant3.name)
    expect(@plant3.name).to appear_before(@plant1.name)
  end
end
