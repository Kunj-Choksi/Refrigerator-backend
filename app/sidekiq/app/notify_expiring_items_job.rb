class App::NotifyExpiringItemsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    item = PurchaseServices::ItemServices::ExpiringItem.call

    text = "#{item.name} is expiring on #{item.expiration_date.strftime('%B %e, %Y')}"

    FcmUtil::Fcm.call(text:, device_fcm_token: User::Device.first.fcm_token)
  end
end
