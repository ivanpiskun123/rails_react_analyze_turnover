# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    name: 'admin1',
    email: 'admin1@gmail.com',
    password: 'admin123',
    password_confirmation: 'admin123', jti: SecureRandom.uuid
  },
  {
    name: 'admin2',
    email: 'admin2@gmail.com',
    password: 'admin123',
    password_confirmation: 'admin123', jti: SecureRandom.uuid

  },
  {
    name: 'admin3',
    email: 'admin3@gmail.com',
    password: 'admin123',
    password_confirmation: 'admin123', jti: SecureRandom.uuid
  },
  {
    name: 'user1',
    email: 'user1@gmail.com',
    password: 'user123',
    password_confirmation: 'user123', jti: SecureRandom.uuid
  },
  ])

  ProductGroup.create([
    {
        name: 'Газообразные топлива'
    },
    {
        name: 'Жидкие топлива'
    },
    {
        name: 'Твердые топлива'
    },
    {
      name: 'Синтетические топлива'
    }
    ])

    Product.create([
      {
          name: 'Метан',
          product_group_id: 1,
      },
      {
          name: 'Бутан',
          product_group_id: 1,
      },
      {
          name: 'Пропан',
          product_group_id: 1,
      },
      {
          name: 'Гелий',
          product_group_id: 1,
      },


      {
          name: 'Дизельное топливо',
          product_group_id: 2,
      },
      {
        name: 'Бензин',
        product_group_id: 2,
      },
      {
        name: 'Ракетное топливо',
        product_group_id: 2,
      },
      {
        name: 'Мазут',
        product_group_id: 2,
      },


      {
          name: 'Древесная щепа',
          product_group_id: 3,
      },
      {
          name: 'Торф',
          product_group_id: 3,
      },
      {
        name: 'Уголь',
        product_group_id: 3,
      },

      {
        name: 'Битум',
        product_group_id: 4,
      },
      {
        name: 'Полимербензин',
        product_group_id: 4,
      },
      {
        name: 'Биотопливо (пластик)',
        product_group_id: 4,
      },
      {
        name: 'Биотопливо (целлюлоза)',
        product_group_id: 4,
      },
      ])

# creating of months (2018, 2019, 2020, 2021)
  years = ['2018','2019', '2020', '2021']

  sales_plans = [
    [130000, 140000, 135000, 120000, 135000, 145000, 150000, 153000, 156000, 159000, 162000, 164000],
    [165000, 166000, 169000, 172000, 172000, 172000, 173000, 175000, 177000, 179000, 181000, 181000],
    [182000, 184000, 185000, 189000, 189000, 189000, 191000, 191500, 192000, 196000, 198000, 200000],
    [192000, 194000, 194000, 194000, 200000, 203000, 220000, 220500, 221000, 221600, 224000, 245000]
  ]

  price_indexes = [
    [1.00, 1.00, 1.00, 1.02, 1.03, 1.02, 1.03, 1.04, 1.04, 1.06, 1.09, 1.1],
    [1.1, 1.12, 1.13, 1.13, 1.14, 1.15, 1.15, 1.17, 1.185, 1.12, 1.126, 1.2],
    [1.2, 1.3, 1.31, 1.33, 1.34, 1.35, 1.37, 1.38, 1.38, 1.38, 1.38, 1.39],
    [1.28, 1.41, 1.42, 1.44, 1.42, 1.42, 1.46, 1.49, 1.52, 1.53, 1.53, 1.55]
  ]

years.each_with_index do |year, year_idx|
  (0..11).each do |i|
      Month.create({ date: "01-"+(i+1).to_s+"-"+year, sales_plan: sales_plans[year_idx][i], price_index: price_indexes[year_idx][i] })
  end
end

# creating of sales (2018, 2019, 2020)

Month.all.each_with_index do |month, month_id|

  rand(9..13).times do
    Sale.create({
      amount: rand(30..2500),
      payment_method: [true, false].sample,
      trade_form: [true, false].sample,
      month: month,
      product_id: rand(1..15),
      total_sum: rand(12000..17000)
      })
  end

end


AdminUser.create!(email: 'admin1@gmail.com', password: 'admin123', password_confirmation: 'admin123') if Rails.env.development?