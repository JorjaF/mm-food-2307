require 'rails_helper'

RSpec.feature 'Search Foods', type: :feature do
  scenario 'User searches for "sweet potatoes"' do
    visit root_path

    fill_in 'q', with: 'sweet potatoes'

    click_button 'Search'

    expect(current_path).to eq(foods_path)

    json_response = JSON.parse(page.body, symbolize_names: true)
    expect(json_response).to have_key(:total_results)

    expect(json_response[:foods]).to be_an(Array)
    expect(json_response[:foods].size).to eq(10)

    json_response[:foods].each do |food|
      expect(food).to have_key(:gtinUpc)
      expect(food).to have_key(:description)
      expect(food).to have_key(:brandOwner)
      expect(food).to have_key(:ingredients)
    end
  end
end
