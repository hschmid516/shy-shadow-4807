class Garden < ApplicationRecord
  has_many :plots

  def plants
    plots.joins(:plants)
         .select('plants.*, ''COUNT(plots.id) as plot_count')
         .where('plants.days_to_harvest < 100')
         .group('plants.id')
         .order(plot_count: :desc)
  end
end
