class SwaggerUiController < ApplicationController
  def index
    render file: 'public/swagger-ui/index.html'
  end
end
