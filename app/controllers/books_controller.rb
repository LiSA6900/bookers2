class BooksController < ApplicationController
  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
    # @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book.user_id = current_user.id
  end

  def edit
    @book = Book.find(params[:id])
    if @book.id == current_user.id
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end