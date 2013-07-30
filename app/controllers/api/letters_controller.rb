class Api::LettersController < ApplicationController
  def index
    respond_with :api, Letter.all
  end
  
  def show
    respond_with :api, Letter.find(params[:id])
  end
  
  def create
    respond_with :api, Letter.create(params[:letter])
  end
  
  def update
    respond_with :api, Letter.update(params[:id], params[:letter])
  end
  
  def destroy
    respond_with :api, Letter.destroy(params[:id])
  end
end
