class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "Book was successfully added."
      redirect_to books_path
    else
      flash.now[:alert] = "There was a problem adding the book."
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to books_path
    else
      flash.now[:alert] = "There was a problem updating the book."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/1

  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book.destroy
    flash[:notice] = "Book was successfully deleted."
    redirect_to books_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author, :price, :publish_date)
    end
end
