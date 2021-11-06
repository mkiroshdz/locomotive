class PingApi < Locomotive::Api
  def index
    respond_with 'Pong', status: 200
  end
end
