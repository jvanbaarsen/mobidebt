require 'spec_helper'

describe UsersController do
  before(:each) { @controller.stub(:current_user).and_return User.new }
  context '#index' do
    it 'renders the :index template' do
      User.any_instance.stub(:all)
      get :index
      expect(response).to render_template :index
    end

    it 'finds all the users and assigns it' do
      user_1, user_2 = User.new, User.new
      User.stub(:all).and_return [user_1, user_2]
      get :index
      expect(assigns[:users]).to eq([user_1, user_2])
    end
  end

  context '#new' do
    before(:each) { @controller.current_user = nil }
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns a new user object' do
      get :new
      expect(assigns[:user]).to be_a(User)
    end
  end

  context '#create' do
    before(:each) { @controller.current_user = nil }
    context 'with valid information' do
      it 'creates a user' do
        user = User.new
        User.stub(:new).and_return user
        user.stub(:save).and_return true
        expect(user).to receive(:save)
        post :create, user: FactoryGirl.attributes_for(:user)
      end

      it 'redirects to the login path' do
        User.any_instance.stub(:save).and_return true
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to login_path
      end

      it 'sets a notice flash message' do
        User.any_instance.stub(:save).and_return true
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'with invalid information' do
      it 'renders the :new template' do
        User.any_instance.stub(:save).and_return false
        post :create, user: {invalid_info: ''}
        expect(response).to render_template :new
      end
    end
  end

  context '#show' do
    it 'renders the :show template' do
      get :show
      expect(response).to render_template :show
    end

    it 'assigns the current user' do
      get :show
      expect(assigns[:user]).to eq(@controller.current_user)
    end
  end

end
