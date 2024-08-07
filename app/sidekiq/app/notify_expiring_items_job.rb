# class App::NotifyExpiringItemsJob < ActiveJob::Base
#   queue_as :default

#   def perform(*_args)
#     item = PurchaseServices::ItemServices::ExpiringItem.call

#     p "item%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
#     p item
#   end
# end

require 'sidekiq-scheduler'

class App::NotifyExpiringItemsJob
  include Sidekiq::Worker

  def perform(*_args)
    item = PurchaseServices::ItemServices::ExpiringItem.call

    p "item%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    p item
  end
end
