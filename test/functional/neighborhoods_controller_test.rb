require 'test_helper'

class NeighborhoodsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:neighborhoods)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_neighborhood
    assert_difference('Neighborhood.count') do
      post :create, :neighborhood => { }
    end

    assert_redirected_to neighborhood_path(assigns(:neighborhood))
  end

  def test_should_show_neighborhood
    get :show, :id => neighborhoods(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => neighborhoods(:one).id
    assert_response :success
  end

  def test_should_update_neighborhood
    put :update, :id => neighborhoods(:one).id, :neighborhood => { }
    assert_redirected_to neighborhood_path(assigns(:neighborhood))
  end

  def test_should_destroy_neighborhood
    assert_difference('Neighborhood.count', -1) do
      delete :destroy, :id => neighborhoods(:one).id
    end

    assert_redirected_to neighborhoods_path
  end
end
