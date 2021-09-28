require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Test Cat"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Test Cat", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: " "}}
    end
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    assert_match "unable to save", response.body
  end

end
