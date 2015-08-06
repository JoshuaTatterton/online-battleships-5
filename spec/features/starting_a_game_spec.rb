require 'spec_helper'

feature 'Starting a new game' do

  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
    our_name="Richard"
    fill_in "name", with: our_name
    click_button 'Submit'
    expect(page).to have_content "Hello, #{our_name}"
  end

  scenario 'Gives default name if none submitted' do
    visit '/'
    click_link 'New Game'
    click_button 'Submit'
    expect(page).to have_content "Hello, Player 1"
  end

  scenario 'Starts a new game' do
    visit '/play'
    click_button 'Start Game'
    expect(page).to have_content "ABCDEFGHIJ"
  end

  scenario 'can view opponents board' do
    visit '/start_game'
    expect(page).to have_content "ABCDEFGHIJ"
  end

  scenario 'i can enter coordinates' do
    visit '/start_game'
    fill_in 'coordinates', with: 'A1'
    click_button 'Fire'
    expect(page).to have_content 'miss'
    fill_in 'coordinates', with: 'B1'
    click_button 'Fire'
    expect(page).to have_content 'hit'
  end

  scenario 'i can play a p2p game' do
    visit '/play'
    click_link 'Register Player2'
    expect(page).to have_content 'Enter Player2s name'
  end

  scenario 'i can register player2' do
    visit '/'
    click_link 'New Game'
    click_button 'Submit'
    click_link 'Register Player2'
    click_button 'Submit'
    expect(page).to have_content 'Player1 vs Player2'
  end

end

feature 'playing the game' do
  scenario 'i can win the game' do
    visit '/start_game'
    fill_in 'coordinates', with: 'B1'
    click_button 'Fire'
    fill_in 'coordinates', with: 'B2'
    click_button 'Fire'
    fill_in 'coordinates', with: 'B3'
    click_button 'Fire'
    fill_in 'coordinates', with: 'B4'
    click_button 'Fire'
    expect(page).to have_content 'sunk'
  end

  scenario 'i can start a new game' do
    visit '/start_game'
    fill_in 'coordinates', with: 'B1'
    click_button 'Fire'
    fill_in 'coordinates', with: 'B2'
    click_button 'Fire'
    fill_in 'coordinates', with: 'B3'
    click_button 'Fire'
    fill_in 'coordinates', with: 'B4'
    click_button 'Fire'
    expect(page).to have_link 'New Game'
    click_link 'New Game'
    expect(page).to have_content 'New Game'
  end
end
