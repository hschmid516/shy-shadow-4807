require 'rails_helper'

RSpec.describe 'plots index' do
  before :each do
    @garden = Garden.create!(name: "Schmiddy's Botanicals", organic: true)
    @plot1 = @garden.plots.create!(number: 42, size: 'Large', direction: 'Northeast')
    @plot2 = @garden.plots.create!(number: 87, size: 'Medium', direction: 'Southwest')
    @plant1 = @plot1.plants.create!(name: 'kale', description: 'green', days_to_harvest: 30)
    @plant2 = @plot1.plants.create!(name: 'tomato', description: 'red', days_to_harvest: 20)
    @plant3 = @plot2.plants.create!(name: 'pepper', description: 'yellow', days_to_harvest: 10)
    visit plots_path
  end

  it 'shows all plot numbers' do
    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plot2.number)
  end

  it 'shows all plants under plots' do
    within("#plot-#{@plot1.id}") do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)
    end

    within("#plot-#{@plot2.id}") do
      expect(page).to have_content(@plant3.name)
      expect(page).to_not have_content(@plant1.name)
      expect(page).to_not have_content(@plant2.name)
    end
  end
end
