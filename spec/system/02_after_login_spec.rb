require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user_image) { Rails.root.join('spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(post_image) }
  let(:user) { create(:user,name:'name',email:'email',password:'password',image:'image')}
  let!(:post) { create(:post,caption:'caption') }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it '投稿を押すと、新規投稿画面に遷移する' do
        newpost_link = find_all('a')[1].native.inner_text
        newpost_link = newpost_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link newpost_link
        is_expected.to eq '/posts/new'
      end
      it 'マイページを押すと、自分のユーザ詳細画面に遷移する' do
        mypage_link = find_all('a')[2].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '投稿一覧を押すと、投稿一覧画面に遷移する' do
        posts_link = find_all('a')[3].native.inner_text
        posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link posts_link
        is_expected.to eq '/posts'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '投稿表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it '自分の投稿と他人の投稿の動画が表示される' do
        expect(page).to have_content post.video
        expect(page).to have_content other_post.video
      end
      it '自分と他人の投稿編集ボタンが正しく表示されている' do
        expect(page).to have_link '', href: edit_post_path(post.user)
        expect(page).to have_link '', href: edit_post_path(other_post.user)
      end
      it '自分の投稿と他人の投稿のコメントが表示される' do
        expect(page).to have_content post.comment
        expect(page).to have_content other_post.comment
      end
    end

    context 'Google mapの表示されている' do
      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
      context 'when the request is valid' do
        before { get '/posts', params: { api_key: 'AIzaSyBF_KarniT2enD5AAGa_yZ48HhVc-c5ryM'} }
        it 'returns status code 400' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe '新規投稿画面のテスト' do
    context '投稿成功のテスト: *投稿ボタンの遷移は『ヘッダーのテスト』でテスト済です。' do
      before do
        visit new_post_path
        fill_in 'post[video]', with: 'video'
        fill_in 'post[caption]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect {click_button '作成する'}.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の一覧画面になっている' do
        click_button '作成する'
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it '投稿のvideoが表示される' do
        expect(page).to have_content post.video
      end
      it '投稿のcaptionが表示される' do
        expect(page).to have_content post.caption
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除する', href: post_path(post)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除する'
      end

      it '正しく削除される' do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_book_path(book)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it 'video編集フォームが表示される' do
        expect(page).to have_field 'post[video]', with: post.video
      end
      it 'caption編集フォームが表示される' do
        expect(page).to have_field 'post[caption]', with: post.caption
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新する'
      end

    end

    context '編集成功のテスト' do
      before do
        @post_old_video = post.video
        @post_old_caption = post.caption
        fill_in 'post[video]', with: 'video'
        fill_in 'book[caption]', with: Faker::Lorem.characters(number: 19)
        click_button '更新する'
      end

      it 'videoが正しく更新される' do
        expect(post.reload.video).not_to eq @post_old_video
      end
      it 'captionが正しく更新される' do
        expect(post.reload.caption).not_to eq @post_old_caption
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts/' + post.id.to_s
        expect(page).to have_content '更新する'
      end
    end
  end

  describe 'マイページのテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '「登録者情報」と表示される' do
        expect(page).to have_content '登録者情報'
      end
      it '登録者情報のユーザ画像が表示される' do
        expect(page).to have_content user.image
      end
      it '登録者情報に自分の名前とメールアドレスが表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
      it '編集ボタンが表示される' do
        expect(page).to have_button '編集する'
      end
    end
  end

  describe 'マイページの情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '編集保存ボタンが表示される' do
        expect(page).to have_button '編集内容を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_email = user.email
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[email]', with: Faker::Lorem.characters(number: 9)
        click_button '編集内容を保存'
      end

      it "画像がアップロードされる" do
        image = create(:image)
        expect(image).to be_valid
      end
      it "エラーになる" do
        image = build(:image, images: nil)
        expect(image).to be_invalid
        expect(image.errors.messages[:images]).to eq ["can't be blank"]
      end
      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end