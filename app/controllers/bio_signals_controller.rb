class BioSignalsController < ApplicationController
  # GET /bio_signals
  # GET /bio_signals.json
  def index
    @bio_signals = BioSignal.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bio_signals }
    end
  end

  # GET /bio_signals/1
  # GET /bio_signals/1.json
  def show
    @bio_signal = BioSignal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bio_signal }
    end
  end

  # GET /bio_signals/new
  # GET /bio_signals/new.json
  def new
    @bio_signal = BioSignal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bio_signal }
    end
  end

  # GET /bio_signals/1/edit
  def edit
    @bio_signal = BioSignal.find(params[:id])
  end

  # POST /bio_signals
  # POST /bio_signals.json
  def create
    @bio_signal = BioSignal.new(params[:bio_signal])

    respond_to do |format|
      if @bio_signal.save
        format.html { redirect_to @bio_signal, notice: 'Bio signal was successfully created.' }
        format.json { render json: @bio_signal, status: :created, location: @bio_signal }
      else
        format.html { render action: "new" }
        format.json { render json: @bio_signal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bio_signals/1
  # PUT /bio_signals/1.json
  def update
    @bio_signal = BioSignal.find(params[:id])

    respond_to do |format|
      if @bio_signal.update_attributes(params[:bio_signal])
        format.html { redirect_to @bio_signal, notice: 'Bio signal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bio_signal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bio_signals/1
  # DELETE /bio_signals/1.json
  def destroy
    @bio_signal = BioSignal.find(params[:id])
    @bio_signal.destroy

    respond_to do |format|
      format.html { redirect_to bio_signals_url }
      format.json { head :no_content }
    end
  end
end
