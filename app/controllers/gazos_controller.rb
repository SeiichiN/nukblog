class GazosController < ApplicationController
  before_action :set_gazo, only: [:show, :edit, :update, :destroy]
  before_action :auth, only: [:index, :new, :edit]

  # GET /gazos
  # GET /gazos.json
  def index
    @gazos = Gazo.all
  end

  # GET /gazos/1
  # GET /gazos/1.json
  def show
  end

  # GET /gazos/new
  def new
    @gazo = Gazo.new
  end

  # GET /gazos/1/edit
  def edit
  end

  # POST /gazos
  # POST /gazos.json
  def create
    @gazo = Gazo.new(gazo_params)

    respond_to do |format|
      if @gazo.save
        format.html { redirect_to @gazo, notice: 'Gazo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gazo }
      else
        format.html { render action: 'new' }
        format.json { render json: @gazo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gazos/1
  # PATCH/PUT /gazos/1.json
  def update
    respond_to do |format|
      if @gazo.update(gazo_params)
        format.html { redirect_to @gazo, notice: 'Gazo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gazo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gazos/1
  # DELETE /gazos/1.json
  def destroy
    @gazo.destroy
    respond_to do |format|
      format.html { redirect_to gazos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gazo
      @gazo = Gazo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gazo_params
      params.require(:gazo).permit(:file, :comment, :ctype, :image)
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
