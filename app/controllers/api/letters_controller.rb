class Api::LettersController < Api::BaseController
  def index
    @q=Letter.search(params[:q])
    @letters=@q.result()
    respond_with :api, @letters
  end
  
  def show
    respond_with :api, Letter.find(params[:id])
  end
  
  def create
    respond_with :api, Letter.create(params[:letter])
  end
  
  def edit
    respond_with :api, Letter.find(params[:id])
  end
  
  def update
    respond_with :api, Letter.update(params[:id], params[:letter])
  end
  
  def destroy
    respond_with :api, Letter.destroy(params[:id])
  end
end
