class Garden < ApplicationRecord
  has_many :plots

  def plants
    plots.joins(:plants).select(:name).distinct
  end
end
