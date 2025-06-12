class PractitionersController < ApplicationController
  def index
    practitioners = Practitioner.includes(:names, :contact_informations, :credentials, :qualifications, :addresses, :photos, :communications)
    render json: practitioners.map { |p| PractitionerSerializer.new(p).as_json }
  end

  def show
    practitioner = Practitioner.includes(:names, :contact_informations, :credentials, :qualifications, :addresses, :photos, :communications).find(params[:id])
    render json: PractitionerSerializer.new(practitioner).as_json
  end
end
