class App::NotifyExpiringItemsJob < ActiveJob::Base
  queue_as :default

  def perform(*_args)
    item = PurchaseServices::ItemServices::ExpiringItem.call

    p "item%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
    p item
    item.update(name: "#{item.name}_#{Time.now}")
  end
end