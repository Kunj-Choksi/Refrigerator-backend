class App::NotifyExpiringItemsJob < ActiveJob::Base
  queue_as :default

  def perform(*_args)
    item = PurchaseServices::ItemServices::ExpiringItem.call

    text = "#{item.name} is expiring on #{item.expiration_date}"

    FcmUtil::Fcm.call(text: text, device_fcm_token: User::Device.first.fcm_token)
  end
end