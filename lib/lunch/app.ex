defmodule Lunch.App do
  use Commanded.Application, otp_app: :lunch

  router(Lunch.Router)
end
