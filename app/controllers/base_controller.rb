class BaseController < ApplicationController
  def create
    render :errors unless resource.save
  end

  def destroy
    resource.destroy
    head 204
  end

  def update
    render :errors unless resource.update(resource_params)
  end
end
