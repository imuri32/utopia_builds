# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'

Color.destroy_all
ProductColor.destroy_all
Product.destroy_all
Brand.destroy_all
ProductType.destroy_all

filename = Rails.root.join("db/case.json")
file = open(filename)
json = file.read
cases = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "Case")

cases.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_case |
      new_case.price = c["price_usd"]
      new_case.rating = c["rating"]
      new_case.brand = product_brand

      if c["color"].include? "/"
        colors = c["color"].split(" / ")

        colors.each do |color|
          new_color = Color.find_or_create_by(name: color)

          if new_color && new_color.valid?
            ProductColor.find_or_create_by(product: new_case, color: new_color)
          end
        end
      else
        new_color = Color.find_or_create_by(name: c["color"])
        ProductColor.find_or_create_by(product: new_case, color: new_color)
      end

      puts "Invalid case #{c["name"]}" unless new_case.valid?
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

puts "Created #{ProductType.count} Product Types"
puts "Created #{Product.count} Products"
puts "Created #{Brand.count} Brands"
puts "Created #{Color.count} Colors"


