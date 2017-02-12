class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :auth, only: [:index, :new, :edit]

  # GET /entries
  # GET /entries.json
  def index
    # @entries = Entry.all
		@q = Entry.ransack(params[:q])
		@entries = @q.result.order(created_at: :desc)
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    counter = @entry.count
    if counter == nil then
      counter = 0
    end
    counter += 1
    @entry.count = counter
    @entry.save
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  def upload_process
    # アップロードファイルを取得
    file = params[:upfile]
    # ファイルのベース名（パスを除いた部分）を取得
    name = file.original_filename
    # 許可する拡張子を定義
    perms = ['.jpg', '.jpeg', '.gif', '.png']
    # 配列permsにアップロードファイルの拡張子に合致するものがあるか
    if !perms.include?(File.extname(name).downcase)
      @result = 'アップロードできるのは画像ファイルのみです。'
      # アップロードファイルのサイズが1MB以下であるか
    elsif file.size > 1.megabyte
      @result = 'ファイルサイズは1MBまでです。'
    else
      File.open("app/assets/images/upload/#{name}", 'wb') { |f| f.write(file.read) }
      @result = "/assets/upload/#{name}:アップロードしました。"
    end
    # 成功/エラーメッセージを保存
    render 'upload'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :body, :cathegory, :tag, :count, :created_at)
    end

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
