# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'

ProductColor.destroy_all
Color.destroy_all
Product.destroy_all
Brand.destroy_all
ProductType.destroy_all

# Adding PC Cases

puts "Importing PC Cases"

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

      puts "Adding #{c["name"]}"

      if c["color"]

        puts "Adding Colors for #{c["name"]}"

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
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

# Adding CPUs

puts "Importing CPUs"

filename = Rails.root.join("db/cpu.json")
file = open(filename)
json = file.read
cpus = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "CPU")

cpus.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_cpu |
      new_cpu.price = c["price_usd"]
      new_cpu.rating = c["rating"]
      new_cpu.brand = product_brand

      if c["color"]
        if c["color"].include? "/"
          colors = c["color"].split(" / ")

          colors.each do |color|
            new_color = Color.find_or_create_by(name: color)

            if new_color && new_color.valid?
              ProductColor.find_or_create_by(product: new_cpu, color: new_color)
            end
          end
        else
          new_color = Color.find_or_create_by(name: c["color"])
          ProductColor.find_or_create_by(product: new_cpu, color: new_color)
        end

        puts "Invalid case #{c["name"]}" unless new_cpu.valid?
      end
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

# Adding CPU Coolers

puts "Importing CPU Coolers"

filename = Rails.root.join("db/cpu-cooler.json")
file = open(filename)
json = file.read
coolers = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "CPU Cooler")

coolers.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_cooler |
      new_cooler.price = c["price_usd"]
      new_cooler.rating = c["rating"]
      new_cooler.brand = product_brand

      if !c["color"].nil?
        if c["color"].include? "/"
          colors = c["color"].split(" / ")

          colors.each do |color|
            new_color = Color.find_or_create_by(name: color)

            if new_color && new_color.valid?
              ProductColor.find_or_create_by(product: new_cooler, color: new_color)
            end
          end
        else
          new_color = Color.find_or_create_by(name: c["color"])
          ProductColor.find_or_create_by(product: new_cooler, color: new_color)
        end

          puts "Invalid case #{c["name"]}" unless new_cooler.valid?
      end
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

# Adding Memory/RAM

puts "Importing Memory/RAM"

filename = Rails.root.join("db/memory.json")
file = open(filename)
json = file.read
memory = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "Memory")

memory.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_memory |
      new_memory.price = c["price_usd"]
      new_memory.rating = c["rating"]
      new_memory.brand = product_brand

      if !c["color"].nil?
        if c["color"].include? "/"
          colors = c["color"].split(" / ")

          colors.each do |color|
            new_color = Color.find_or_create_by(name: color)

            if new_color && new_color.valid?
              ProductColor.find_or_create_by(product: new_memory, color: new_color)
            end
          end
        else
          new_color = Color.find_or_create_by(name: c["color"])
          ProductColor.find_or_create_by(product: new_memory, color: new_color)
        end

        puts "Invalid case #{c["name"]}" unless new_memory.valid?
      end
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

# Adding Motherboards

puts "Importing Motherboards"

filename = Rails.root.join("db/motherboard.json")
file = open(filename)
json = file.read
motherboards = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "Motherboard")

motherboards.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_motherboard |
      new_motherboard.price = c["price_usd"]
      new_motherboard.rating = c["rating"]
      new_motherboard.brand = product_brand

      if !c["color"].nil?
        if c["color"].include? "/"
          colors = c["color"].split(" / ")

          colors.each do |color|
            new_color = Color.find_or_create_by(name: color)

            if new_color && new_color.valid?
              ProductColor.find_or_create_by(product: new_motherboard, color: new_color)
            end
          end
        else
          new_color = Color.find_or_create_by(name: c["color"])
          ProductColor.find_or_create_by(product: new_motherboard, color: new_color)
        end

        puts "Invalid case #{c["name"]}" unless new_motherboard.valid?
      end
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

# Adding Power Supplies

puts "Importing Power Supplies"

filename = Rails.root.join("db/power-supply.json")
file = open(filename)
json = file.read
power_supplies = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "Power Supply")

power_supplies.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_power_supply |
      new_power_supply.price = c["price_usd"]
      new_power_supply.rating = c["rating"]
      new_power_supply.brand = product_brand

      if !c["color"].nil?
        if c["color"].include? "/"
          colors = c["color"].split(" / ")

          colors.each do |color|
            new_color = Color.find_or_create_by(name: color)

            if new_color && new_color.valid?
              ProductColor.find_or_create_by(product: new_power_supply, color: new_color)
            end
          end
        else
          new_color = Color.find_or_create_by(name: c["color"])
          ProductColor.find_or_create_by(product: new_power_supply, color: new_color)
        end

        puts "Invalid case #{c["name"]}" unless new_power_supply.valid?
      end
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

# Adding Power Supplies

puts "Importing Video Cards"

filename = Rails.root.join("db/video-card.json")
file = open(filename)
json = file.read
video_cards = JSON.parse(json)

product_type = ProductType.find_or_create_by(name: "Video Card")

video_cards.each do |c|
  if product_type && product_type.valid?

    brand_array = c["name"].split(" ")

    product_brand = Brand.find_or_create_by(name: brand_array[0])

    product_type.products.find_or_create_by(name: c["name"]) do | new_video_card |
      new_video_card.price = c["price_usd"]
      new_video_card.rating = c["rating"]
      new_video_card.brand = product_brand

      if !c["color"].nil?
        if c["color"].include? "/"
          colors = c["color"].split(" / ")

          colors.each do |color|
            new_color = Color.find_or_create_by(name: color)

            if new_color && new_color.valid?
              ProductColor.find_or_create_by(product: new_video_card, color: new_color)
            end
          end
        else
          new_color = Color.find_or_create_by(name: c["color"])
          ProductColor.find_or_create_by(product: new_video_card, color: new_color)
        end

        puts "Invalid case #{c["name"]}" unless new_video_card.valid?
      end
    end
  else
    puts "Invalid product type #{c["name"]}."
  end
end

puts "Created #{ProductType.count} Product Types"
puts "Created #{Product.count} Products"
puts "Created #{Brand.count} Brands"
puts "Created #{Color.count} Colors"
