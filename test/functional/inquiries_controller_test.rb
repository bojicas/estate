require 'test_helper'

class InquiriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:inquiries)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_inquiry
    assert_difference('Inquiry.count') do
      post :create, :inquiry => { }
    end

    assert_redirected_to inquiry_path(assigns(:inquiry))
  end

  def test_should_show_inquiry
    get :show, :id => inquiries(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => inquiries(:one).id
    assert_response :success
  end

  def test_should_update_inquiry
    put :update, :id => inquiries(:one).id, :inquiry => { }
    assert_redirected_to inquiry_path(assigns(:inquiry))
  end

  def test_should_destroy_inquiry
    assert_difference('Inquiry.count', -1) do
      delete :destroy, :id => inquiries(:one).id
    end

    assert_redirected_to inquiries_path
  end
end
