# Clear old data
Vote.delete_all
Recommendation.delete_all
Book.delete_all
User.delete_all

# Create users
user1 = User.create!(email: "reader1@example.com", password: "password", username: "ReaderOne")
user2 = User.create!(email: "reader2@example.com", password: "password", username: "ReaderTwo")

# Create books
books = Book.create!([
  { title: "To Kill a Mockingbird", author: "Harper Lee", image_url: "https://covers.openlibrary.org/b/id/8225261-L.jpg" },
  { title: "1984", author: "George Orwell", image_url: "https://covers.openlibrary.org/b/id/7222246-L.jpg" },
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", image_url: "https://covers.openlibrary.org/b/id/7222276-L.jpg" },
  { title: "Pride and Prejudice", author: "Jane Austen", image_url: "https://covers.openlibrary.org/b/id/8091016-L.jpg" },
  { title: "The Catcher in the Rye", author: "J.D. Salinger", image_url: "https://covers.openlibrary.org/b/id/8231856-L.jpg" },
  { title: "Brave New World", author: "Aldous Huxley", image_url: "https://covers.openlibrary.org/b/id/8774036-L.jpg" },
  { title: "Moby-Dick", author: "Herman Melville", image_url: "https://covers.openlibrary.org/b/id/7222241-L.jpg" },
  { title: "The Hobbit", author: "J.R.R. Tolkien", image_url: "https://covers.openlibrary.org/b/id/6979861-L.jpg" },
  { title: "Fahrenheit 451", author: "Ray Bradbury", image_url: "https://covers.openlibrary.org/b/id/8228691-L.jpg" },
  { title: "Jane Eyre", author: "Charlotte Brontë", image_url: "https://covers.openlibrary.org/b/id/8231994-L.jpg" }
])

# Add recommendations
books.each_with_index do |book, i|
  user = i.even? ? user1 : user2
  Recommendation.create!(
    book: book,
    user: user,
    review: "I really enjoyed reading '#{book.title}'! Highly recommended for anyone who loves #{book.author}."
  )
end

# Add votes
Recommendation.all.each do |rec|
  Vote.create!(user: user1, recommendation: rec) unless rec.user == user1
  Vote.create!(user: user2, recommendation: rec) unless rec.user == user2
end

puts "✅ Seeded #{User.count} users, #{Book.count} books, #{Recommendation.count} recommendations, #{Vote.count} votes!"
