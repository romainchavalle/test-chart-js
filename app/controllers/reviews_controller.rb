class ReviewsController < ApplicationController
  def index
    @restaurant = Restaurant.last
    @reviews = @restaurant.reviews.order(:date)
    @reviews_group_by_date = @reviews.group_by { |review| review.date.to_date } #regrouper les reviews par date dans un hash d'array {date[review1, review2,...]}
    @average_ratings_by_date = @reviews_group_by_date.map do |date, reviews| #pour chaque date, on vient calculer la moyenne et stocker le résultat dans un hash
      average_rating = reviews.sum(&:rating).to_f / reviews.size
      [date, average_rating]
    end.to_h

    @dates = @average_ratings_by_date.keys #définir les dates
    @ratings = @average_ratings_by_date.values #définir les notes moyennes

    #caclul de la moyenne générale
    sum = 0
    @reviews.each { | review | sum += review.rating }
    @main_average_rating = sum.to_f / @reviews.size
  end
end
