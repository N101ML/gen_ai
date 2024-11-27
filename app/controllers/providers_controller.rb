class ProvidersController < ApplicationController
  def index
    @providers = Provider.where("name LIKE ?", "%#{params[:filter]}%")
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      render turbo_stream: turbo_stream.append(
        dom_id(@providers),
        partial: "shared/resource_table",
        locals: { item: @provider, headers: { "Provider" => 'name' } }
      )
    else
      render turbo_stream: turbo_stream.replace(
        dom_id(@provider, "form"),
        locals: { provider: @provider }
      )
    end
  end
end
