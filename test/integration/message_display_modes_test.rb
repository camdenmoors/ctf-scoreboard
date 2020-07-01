require 'test_helper'

class ApplicationDisplayModesTest < ActionDispatch::IntegrationTest
  include TeamsHelper
  include Devise::Test::IntegrationHelpers

  test 'messages header shows on messages page' do
    sign_in create(:user)
    get "/game/messages"
    assert_select 'h1', /Messages/
  end

  test 'no messages shows when there are no messages' do
    sign_in create(:user)
    get "/game/messages"
    assert_select 'h4', /No Messages/
  end

  test 'messages display contents correctly' do
    message = create(:message, title: 'Example Title', text: 'Example Text')

    get "/game/messages"
    assert_select 'div[class=message]' do
      assert_select 'h2', /Example Title/
      assert_select 'p', /Example Text/
    end
  end
end
