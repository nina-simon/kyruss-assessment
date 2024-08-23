require 'rails_helper'

RSpec.describe CheckInsController, type: :controller do
  before do
    stub_request(:get, "https://dummyjson.com/users/1").
      to_return(status: 200, body: { firstName: "John", lastName: "Doe" }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  describe "routing" do
    it { should route(:get, "/check_ins/new").to(action: :new) }
    it { should route(:post, "/check_ins").to(action: :create) }
    it { should route(:get, "/check_ins/1").to(action: :show, id: 1) }
    it { should route(:put, "/check_ins/1").to(action: :update, id: 1) }
  end

  describe "GET #new" do
    it "renders the view" do
      get :new

      expect(response).to render_template(:new)
      expect(response).to render_with_layout(:application)
    end
  end

  describe "POST #create" do
    let(:questionnaire) { create(:questionnaire, title: 'PHQ-2 Patient Depression Screening') }
    let(:question1) { create(:question, questionnaire: questionnaire, text: "Question 1", options: [{ "text" => "Not at all", "value" => 0 }, { "text" => "Several days", "value" => 1 }]) }
    let(:question2) { create(:question, questionnaire: questionnaire, text: "Question 2", options: [{ "text" => "Not at all", "value" => 0 }, { "text" => "Several days", "value" => 1 }]) }

    before do
      allow(Questionnaire).to receive(:find_by).and_return(questionnaire)
      allow(questionnaire).to receive(:questions).and_return([question1, question2])
      allow(CheckIn).to receive(:create).and_call_original
    end

    it "creates a new check_in" do
      expect { post(:create, params: { check_in: { patient_id: "1", responses: { question1.id.to_s => "1", question2.id.to_s => "0" } } }) }.to change(CheckIn, :count).by(1)
    end

    it "redirects to the check_in show page" do
      post :create, params: { check_in: { patient_id: "1", responses: { question1.id.to_s => "1", question2.id.to_s => "0" } } }

      expect(response).to redirect_to check_in_path(CheckIn.last)
    end
  end

  describe "GET #show" do
    it "finds the check_in" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:find).with("1").and_return(check_in)

      get :show, params: { id: 1 }

      expect(CheckIn).to have_received(:find).with("1")
    end

    it "shows the current check in" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:create).and_return(check_in)

      get :show, params: { id: 1 }

      expect(response).to render_template(:show)
      expect(response).to render_with_layout(:application)
    end
  end

  describe "PUT #update" do
    it "finds the check_in" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:find).with("1").and_return(check_in)

      put :update, params: { id: 1 }

      expect(CheckIn).to have_received(:find).with("1")
    end

    it "redirects to the new check_in page" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:find).with("1").and_return(check_in)

      put :update, params: { id: 1 }

      expect(response).to redirect_to new_check_in_path
    end
  end
end
