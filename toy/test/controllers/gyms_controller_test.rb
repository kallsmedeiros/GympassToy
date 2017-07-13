require 'test_helper'

class GymsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gym = gyms(:one)
  end

  test "should get index" do
    get gyms_url
    assert_response :success
  end

  test "should get new" do
    get new_gym_url
    assert_response :success
  end

  test "should create gym" do
    assert_difference('Gym.count') do
      post gyms_url, params: { gym: { closing: @gym.closing, location_id: @gym.location_id, manager_id: @gym.manager_id, name: @gym.name, opening: @gym.opening } }
    end

    assert_redirected_to gym_url(Gym.last)
  end

  test "should show gym" do
    get gym_url(@gym)
    assert_response :success
  end

  test "should get edit" do
    get edit_gym_url(@gym)
    assert_response :success
  end

  test "should update gym" do
    patch gym_url(@gym), params: { gym: { closing: @gym.closing, location_id: @gym.location_id, manager_id: @gym.manager_id, name: @gym.name, opening: @gym.opening } }
    assert_redirected_to gym_url(@gym)
  end

  test "should destroy gym" do
    assert_difference('Gym.count', -1) do
      delete gym_url(@gym)
    end

    assert_redirected_to gyms_url
  end
end
