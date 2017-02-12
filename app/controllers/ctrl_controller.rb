class CtrlController < ApplicationController
  before_action :auth, only: [:updb_process]

	# アップロードフォームを表示するためのupdbアクション
	# (「〜/ctrl/updb/108」のようなアドレスで呼び出し可能)
	def updb
		id = params[:id]
		if id != nil then
			@gazo = Gazo.find(params[:id])
		elsif id == nil then
			@gazo = Gazo.new
		end
	end

	# 「アップロード」ボタンクリック時に呼びだされ、アップロード処理を実施
	def updb_process
		id = params[:id]
		if id != nil then
			@gazo = Gazo.find(params[:id])
		elsif id == nil then
			@gazo = Gazo.new
		end

		# アップロードファイルをデータベースに保存（失敗時は1番目のエラーのみを表示）
		if @gazo.update(params.require(:gazo).permit(:file, :comment, :data))
#		if @gazo.save(params.require(:gazo).permit(:file, :comment, :data))
			redirect_to gazo_path(@gazo), notice: '保存に成功しました。'
		else
			render text: @gazo.errors.full_messages[0]
		end
	end

	def show_image
		# ルートパラメータが指定されている場合はその値を、さもなければ1をセット。
		id = params[:id] ? params[:id] : 1

		# imameテーブルからid値をキーにレコードを取得
		@gazo = Gazo.find(id)

		# image列(バイナリ型)をレスポンスとして送出
		send_data @gazo.image, type: @gazo.ctype, disposition: :inline
	end

	private
	    def auth
      # userID/Password
      name = 'billie'
      passwd = '0aebf3a9339a0d976e082525062cb64cfc9ba651'
      # 入力されたname,passwordを上のname,passwdと比較する
      authenticate_or_request_with_http_basic('nukblog') do |n,p|
        n == name &&
          Digest::SHA1.hexdigest(p) == passwd
      end
    end

end
