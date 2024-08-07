class App::NotifyExpiringItemsJob < ActiveJob::Base
  queue_as :default

  def perform(*_args)
    item = PurchaseServices::ItemServices::ExpiringItem.call

    p "item%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    p item
  end
end
