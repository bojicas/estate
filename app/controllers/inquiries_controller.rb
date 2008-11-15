class InquiriesController < ApplicationController
  skip_before_filter :login_required, :only => [ :new, :create ]

  # GET /inquiries
  # GET /inquiries.xml
  def index
    @inquiries = Inquiry.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inquiries }
    end
  end

  # GET /inquiries/1
  # GET /inquiries/1.xml
  def show
    @inquiry = Inquiry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inquiry }
    end
  end

  # GET /inquiries/new
  # GET /inquiries/new.xml
  def new
    @inquiry = Inquiry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inquiry }
    end
  end

  # GET /inquiries/1/edit
  def edit
    @inquiry = Inquiry.find(params[:id])
  end

  # POST /inquiries
  # POST /inquiries.xml
  def create
    @inquiry = Inquiry.new(params[:inquiry])

    respond_to do |format|
      if @inquiry.save_with_captcha
        flash[:notice] = 'Inquiry was successfully created.'
        format.html { redirect_to(:back) || redirect_to(@inquiry) }
        format.xml  { render :xml => @inquiry, :status => :created, :location => @inquiry }
      else
        # format.html { render :action => "new" }
        flash[:error] = "We couldn't create your inquity.<br />Image did not match with text"
        format.html { redirect_to(:back) || redirect_to(@inquiry) }
        format.xml  { render :xml => @inquiry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inquiries/1
  # PUT /inquiries/1.xml
  def update
    @inquiry = Inquiry.find(params[:id])

    respond_to do |format|
      if @inquiry.update_attributes(params[:inquiry])
        flash[:notice] = 'Inquiry was successfully updated.'
        format.html { redirect_to(@inquiry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inquiry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inquiries/1
  # DELETE /inquiries/1.xml
  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy

    respond_to do |format|
      format.html { redirect_to(inquiries_url) }
      format.xml  { head :ok }
    end
  end
end
