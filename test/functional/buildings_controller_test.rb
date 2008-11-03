require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_building
    assert_difference('Building.count') do
      post :create, :building => { }
    end

    assert_redirected_to building_path(assigns(:building))
  end

  def test_should_show_building
    get :show, :id => buildings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => buildings(:one).id
    assert_response :success
  end

  def test_should_update_building
    put :update, :id => buildings(:one).id, :building => { }
    assert_redirected_to building_path(assigns(:building))
  end

  def test_should_destroy_building
    assert_difference('Building.count', -1) do
      delete :destroy, :id => buildings(:one).id
    end

    assert_redirected_to buildings_path
  end
end
