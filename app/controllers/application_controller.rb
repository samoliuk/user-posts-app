class ApplicationController < ActionController::API

  def respond_result(res, serializer = nil)
    status_code = res[:error] ? :unprocessable_entity : :ok
    options = {
      status: status_code,
      location: nil
    }
    options[:serializer] = serializer if serializer && !res[:error]

    respond_with res, options
  end
end
