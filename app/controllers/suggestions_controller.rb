class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @suggestions = Suggestion.all
  end

  def show
    @rating = current_user.ratings.where(suggestion_id: @suggestion.id).first_or_create(score: 0)
  end

  def new
    @suggestion = Suggestion.new
  end

  def edit
  end

  def create
    @suggestion = current_user.suggestions.build(suggestion_params)

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_suggestion
      @suggestion = current_user.suggestions.find(params[:id])
    end

    def suggestion_params
      params.require(:suggestion).permit(:title, :description, :image)
    end
end
