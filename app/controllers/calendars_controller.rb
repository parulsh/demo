class CalendarsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper



  def host
    @foods = current_user.foods

    params[:start_date] ||= Date.current.to_s
    params[:food_id] ||= @foods[0] ? @foods[0].id : nil

    if params[:q].present?
      params[:start_date] = params[:q][:start_date]
      params[:food_id] = params[:q][:food_id]
    end

    

    if params[:food_id]
      @food = Food.find(params[:food_id])
      start_date = Date.parse(params[:start_date])

      first_of_month = (start_date - 1.months).beginning_of_month # => Jun 1
      end_of_month = (start_date + 1.months).end_of_month # => Aug 31

      @events = @food.orders.joins(:user)
                      .select('orders.*, users.fullname, users.image, users.email, users.uid')
                      .where('(start_date BETWEEN ? AND ?) AND status <> ?', first_of_month, end_of_month, 2)

    else
      @food = nil
      @events = []

    end
  end


end
