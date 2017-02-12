class HomeController < ApplicationController
  def index
    @entries = Entry.all.order(created_at: :desc).limit(3)
  end
	
	def archive
		if request.post? then
			sort_key = params[:text1]
      key = params[:text2]
      if key=='asc'
        updown = :asc
      else
        updown = :desc
      end
		else
			sort_key = 'created_at'
      updown = :desc
		end

    @entries = Entry.all.order(sort_key => updown)
  end

  def find
    if request.post? then
      s_field = params[:search_field]
      s_word = params[:search_word]
      if s_word != nil then
        @entries = Entry.where("#{s_field} like '%" + s_word + "%'").order(created_at: :desc)
      end
    else
      @entries = Entry.all.order(created_at: :desc)
    end
  end

end
