require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario "They see product image" do
    visit root_path
    # visit product_path(1)
    first(:link, 'Details').click

    # save_screenshot

    expect(page).to have_css 'img.main-img', count: 1
  end

end
