class ProvidersController < ApplicationController
  def index
    filtered = Provider.where("name LIKE ?", "%#{params[:filter]}%")
    @pagy, @providers = pagy(filtered)
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to providers_path, notice: "Provider was successfully created." }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def provider_params
    params.require(:provider).permit(:name)
  end
end
