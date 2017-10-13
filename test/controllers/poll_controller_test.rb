require 'test_helper'

class PollControllerTest < ActionDispatch::IntegrationTest
  context 'index' do
    setup do
      login_user
    end

    should "respond correctly" do
      get polls_url
      assert_response :success
      assert_template :index
    end

    should "List polls" do
      create :poll, question: "holiday destination"
      get polls_url
      assert_match /holiday destination/, @response.body
    end
  end

  context 'new' do
    context 'as admin' do
      setup do
        login_admin
        get new_poll_url
      end

      should "respond correctly" do
        assert_response :success
        assert_template :new
      end

      should "render form" do
        assert_select "form.poll", count: 1
        assert_select "input#poll_title", count: 1
        assert_select "input[type=submit]", count: 1
      end
    end

    context 'as user' do
      setup do
        login_user
        get new_poll_url
      end

      should "respond correctly" do
        assert_response :redirect
        assert_redirected_to root_url
      end

      should "not render form" do
        assert_select "form.poll", count: 0
        assert_select "input#poll_title", count: 0
        assert_select "input[type=submit]", count: 0
      end
    end
  end

  context 'create' do
    context 'as admin' do
      setup { login_admin }

      context 'with invalid params' do
        setup do
          @invalid_params = { title: "" }
        end

        should "not create poll" do
          initial = Poll.count
          post polls_url, params: {poll: @invalid_params}
          assert_equal initial, Poll.count
        end

        should "render form" do
          post polls_url, params: { poll: @invalid_params }
          assert_template :new
          assert_response :success
        end
      end

      context 'with valid params' do
        setup do
          @valid_params = { title: "New poll", question: "New poll", poll_options_attributes: [{ text: "Option 1" }, { text: "Option 2" }]}
        end

        should "create poll" do
          initial = Poll.count
          post polls_url, params: { poll: @valid_params }
          assert_equal initial+1, Poll.count
        end

        should "redirect to polls index" do
          post polls_url, params: { poll: @valid_params }
          assert_response :redirect
          assert_redirected_to polls_url
        end
      end
    end

    context 'as user' do
      setup { login_admin }

      context 'with invalid params' do
        setup do
          @invalid_params = { title: "" }
        end

        should "not create poll" do
          initial = Poll.count
          post polls_url, params: {poll: @invalid_params}
          assert_equal initial, Poll.count
        end

        should "redirect to root" do
          post polls_url, params: { poll: @invalid_params }
          assert_response :redirect
          assert_redirected_to root_url
        end
      end

      context 'with valid params' do
        setup do
          @valid_params = { title: "New poll", question: "New poll", poll_options_attributes: [{ text: "Option 1" }, { text: "Option 2" }]}
        end

        should "not create poll" do
          initial = Poll.count
          post polls_url, params: { poll: @valid_params }
          assert_equal initial, Poll.count
        end

        should "redirect to root" do
          post polls_url, params: { poll: @valid_params }
          assert_response :redirect
          assert_redirected_to root_url
        end
      end 
    end
  end
end
