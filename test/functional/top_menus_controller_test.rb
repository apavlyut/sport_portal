require 'test_helper'

class TopMenusControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:top_menus)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_top_menu
    assert_difference('TopMenu.count') do
      post :create, :top_menu => { }
    end

    assert_redirected_to top_menu_path(assigns(:top_menu))
  end

  def test_should_show_top_menu
    get :show, :id => top_menus(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => top_menus(:one).id
    assert_response :success
  end

  def test_should_update_top_menu
    put :update, :id => top_menus(:one).id, :top_menu => { }
    assert_redirected_to top_menu_path(assigns(:top_menu))
  end

  def test_should_destroy_top_menu
    assert_difference('TopMenu.count', -1) do
      delete :destroy, :id => top_menus(:one).id
    end

    assert_redirected_to top_menus_path
  end
end
