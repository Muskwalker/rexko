require File.dirname(__FILE__) + '/../test_helper'

class LociControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:loci)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_locus
    assert_difference('Locus.count') do
      post :create, :locus => { }
    end

    assert_redirected_to locus_path(assigns(:locus))
  end

  def test_should_show_locus
    get :show, :id => loci(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => loci(:one).id
    assert_response :success
  end

  def test_should_update_locus
    put :update, :id => loci(:one).id, :locus => { }
    assert_redirected_to locus_path(assigns(:locus))
  end

  def test_should_destroy_locus
    assert_difference('Locus.count', -1) do
      delete :destroy, :id => loci(:one).id
    end

    assert_redirected_to loci_path
  end
end