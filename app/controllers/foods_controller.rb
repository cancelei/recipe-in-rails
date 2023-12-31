class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :check_owner, only: %i[edit update destroy]

  # GET /foods
  def index
    @foods = current_user.foods.includes(:user)
  end

  # GET /foods/1
  def show; end

  # GET /foods/new
  def new
    @food = current_user.foods.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods
  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      redirect_to @food, notice: 'Food item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /foods/1
  def update
    if @food.update(food_params)
      redirect_to @food, notice: 'Food item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1
  def destroy
    if @food.user == current_user # Assuming `current_user` is a method that returns the currently logged-in user and the food item has a `user` association.
      @food.recipe_foods.destroy_all
      @food.destroy
      redirect_to foods_url, notice: 'Food item was successfully destroyed.'
    else
      redirect_to foods_url, alert: 'You are not authorized to delete this food item.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Ensure the current user is the owner of the food item
  def check_owner
    return if @food.user_id == current_user.id

    redirect_to foods_path, alert: "Sorry, you don't have access to that page"
    nil
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
