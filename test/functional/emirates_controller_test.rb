require 'test_helper'

class EmiratesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:emirates)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_emirate
    assert_difference('Emirate.count') do
      post :create, :emirate => { }
    end

    assert_redirected_to emirate_path(assigns(:emirate))
  end

  def test_should_show_emirate
    get :show, :id => emirates(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => emirates(:one).id
    assert_response :success
  end

  def test_should_update_emirate
    put :update, :id => emirates(:one).id, :emirate => { }
    assert_redirected_to emirate_path(assigns(:emirate))
  end

  def test_should_destroy_emirate
    assert_difference('Emirate.count', -1) do
      delete :destroy, :id => emirates(:one).id
    end

    assert_redirected_to emirates_path
  end
end
