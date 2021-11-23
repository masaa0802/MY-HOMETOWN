# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



HomeImage.create(
  image: File.open("./app/assets/images/using1.png")
 )
HomeImage.create(
  image: File.open("./app/assets/images/using2.png")
 )
HomeImage.create(
  image: File.open("./app/assets/images/using3.png")
)
HomeImage.create(
  image: File.open("./app/assets/images/using4.png")
)
HomeImage.create(
  image: File.open("./app/assets/images/using5.png")
)



