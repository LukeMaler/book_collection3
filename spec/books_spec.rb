require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    context "with valid params" do
      it "creates a book and sets a success flash message" do
        expect {
          post books_path, params: {
            book: {
              title: "RSpec Book",
              author: "RSpec Author",
              price: 10.50,
              publish_date: "2025-09-11"
            }
          }
        }.to change(Book, :count).by(1)

        follow_redirect! # follow redirect to index
        expect(response.body).to include("Book was successfully added.")

        book = Book.last
        expect(book.author).to eq("RSpec Author")
        expect(book.price.to_f).to eq(10.50)
        expect(book.publish_date.to_s).to eq("2025-09-11")
      end
    end

    context "with no title" do
      it "does not create a book and shows error flash" do
        expect {
          post books_path, params: { book: { title: "" } }
        }.not_to change(Book, :count)

        expect(response.body).to include("There was a problem adding the book.")
      end
    end
    
    context "with no author" do
      it "does not create a book and shows error flash" do
        expect {
          post books_path, params: { book: { author: "" } }
        }.not_to change(Book, :count)
        expect(response.body).to include("There was a problem adding the book.")
      end
    end

    context "with no price" do
      it "does not create a book and shows an error flash" do
        expect {
          post books_path, params: {
            book: {
              title: "RSpec Book",
              author: "RSpec Author",
              price: nil,
              publish_date: "2025-09-11"
            }
          }
        }.not_to change(Book, :count)

        expect(response.body).to include("There was a problem adding the book.")
      end
    end

    context "with no publish date" do
      it "does not create a book and shows an error flash" do
        expect {
          post books_path, params: {
            book: {
              title: "RSpec Book",
              author: "RSpec Author",
              price: 10.50,
              publish_date: ""
            }
          }
        }.not_to change(Book, :count)

        expect(response.body).to include("There was a problem adding the book.")
      end
    end
    
  end
end

