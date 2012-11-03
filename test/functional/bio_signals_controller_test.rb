require 'test_helper'

class BioSignalsControllerTest < ActionController::TestCase
  setup do
    @bio_signal = bio_signals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bio_signals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bio_signal" do
    assert_difference('BioSignal.count') do
      post :create, bio_signal: {  }
    end

    assert_redirected_to bio_signal_path(assigns(:bio_signal))
  end

  test "should show bio_signal" do
    get :show, id: @bio_signal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bio_signal
    assert_response :success
  end

  test "should update bio_signal" do
    put :update, id: @bio_signal, bio_signal: {  }
    assert_redirected_to bio_signal_path(assigns(:bio_signal))
  end

  test "should destroy bio_signal" do
    assert_difference('BioSignal.count', -1) do
      delete :destroy, id: @bio_signal
    end

    assert_redirected_to bio_signals_path
  end
end
