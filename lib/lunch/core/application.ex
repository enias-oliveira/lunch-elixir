defmodule Lunch.Core.Application do
  use Commanded.Application, otp_app: :lunch

  router(Lunch.Core.Router)
end
