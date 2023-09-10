# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

product1 = Product.new(
  name: 'Aぇ! group ステッカー',
  description: 'Aぇ! groupのステッカーです。',
  price: 4200
)
product1.image.attach(io: File.open(Rails.root.join('app/assets/images/Agroup_steaker.jfif')),
                      filename: 'Agroup_steaker.jfif')
product1.save!

product2 = Product.new(
  name: 'なにわ男子 うちわ',
  description: 'なにわ男子のうちわです。',
  price: 800
)
product2.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.png')), filename: 'no_image.png')
product2.save!

product3 = Product.new(
  name: 'なにわ男子 クリアファイル',
  description: 'なにわ男子のクリアファイルです。',
  price: 500
)
product3.image.attach(io: File.open(Rails.root.join('app/assets/images/naniwa_clearfilefolder.jpg')),
                      filename: 'naniwa_clearfilefolder.jpg')
product3.save!

product4 = Product.new(
  name: 'SnowMan ポスター',
  description: 'SnowManのポスターです。',
  price: 1000
)
product4.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.png')), filename: 'no_image.png')
product4.save!

product5 = Product.new(
  name: 'SixTONES ペンライト',
  description: 'SixTONESのペンライトです。',
  price: 1000
)
product5.image.attach(io: File.open(Rails.root.join('app/assets/images/sixtones_light.jpg')),
                      filename: 'sixtones_light.jpg')
product5.save!
