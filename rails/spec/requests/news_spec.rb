require 'rails_helper'

RSpec.describe "News", type: :request do
  let(:news) { create(:news)}
  let(:news_params) { attributes_for(:news)}

  describe "GET /news" do
    it 'request success' do
      get news_index_path
      expect(response).to have_http_status(:ok)
    end

  end

  describe "POST /news" do
    it 'requests success' do
      post "/news",params: {news: news_params}
      expect(response).to have_http_status(:found)
    end

    it 'created news' do
      expect do
        post "/news",params: {news: news_params}
      end.to change { News.count }.by 1
    end
  end

  describe "GET /news/new" do
    it 'request success' do
      get new_news_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /news/:id/edit" do
    it 'request success' do
      get edit_news_path(news.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /news/:id" do
    it "request success" do
      get news_path(news.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /news/:id" do

  end

  describe "DELETE /news/:id" do
    it "request success" do
      delete news_path(news.id)
      expect(response).to have_http_status(:found)
    end

    it 'destroy news' do
      news
      expect do
        delete news_path(news.id)
      end.to change { News.count }.by -1
    end
  end
end
