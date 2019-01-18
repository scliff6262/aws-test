class DescriptionsController < ApplicationController

  # GET /descriptions
  # GET /descriptions.json
  def index
    @descriptions = Description.all
  end

  # GET /descriptions/1
  # GET /descriptions/1.json
  def show
  end

  # GET /descriptions/new
  def new
    @description = Description.new
  end

  # GET /descriptions/1/edit
  def edit
  end

  # POST /descriptions
  # POST /descriptions.json
  def create
    @description = Description.new(description_params)
    s3 = Aws::S3::Resource.new(region:'us-east-1')
    obj = s3.bucket('sean-cliff-test-author-description').object(description_params[:name])
    obj.put(body: description_params[:body].to_json)
  end

  # PATCH/PUT /descriptions/1
  # PATCH/PUT /descriptions/1.json
  def update
  end

  # DELETE /descriptions/1
  # DELETE /descriptions/1.json
  def destroy
    @description.destroy
    respond_to do |format|
      format.html { redirect_to descriptions_url, notice: 'Description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_description
      @description = Description.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def description_params
      params.require(:description).permit(:name, :body)
    end
end
