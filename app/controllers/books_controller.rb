class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user
    book = Book.find(params[:id])
    if current_user.id !=  book.user_id
     redirect_to books_path
    end
  end

 def new
  	@book = Book.new
  end
  def create
  	book = Book.new(book_params)
  	book.user_id = current_user.id
  	if book.save
      flash[:notice]= "Created succesfuly"
      redirect_to book_path(book.id)
    else
      @book = book
      @books = Book.all
      render :index
    end
  end
  def index
    @book = Book.new
  	@books = Book.all
  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]= "Updated succesfuly"
      redirect_to book_path(book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to user_path(current_user.id)
  end

  private
  def book_params
  	params.require(:book).permit(:title, :opinion)
  end
end

