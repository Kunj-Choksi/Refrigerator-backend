require "application_system_test_case"

class PurchasesTest < ApplicationSystemTestCase
  setup do
    @purchase = purchases(:one)
  end

  test "visiting the index" do
    visit purchases_url
    assert_selector "h1", text: "Purchases"
  end

  test "should create purchase" do
    visit purchases_url
    click_on "New purchase"

    fill_in "Billing amount", with: @purchase.billing_amount
    fill_in "Partial amount", with: @purchase.partial_amount
    fill_in "Purchase date", with: @purchase.purchase_date
    fill_in "Purchase type", with: @purchase.purchase_type
    fill_in "Store logo", with: @purchase.store_logo
    fill_in "Store name", with: @purchase.store_name
    fill_in "Verifi", with: @purchase.verifi_id
    fill_in "Verifi metadata", with: @purchase.verifi_metadata
    click_on "Create Purchase"

    assert_text "Purchase was successfully created"
    click_on "Back"
  end

  test "should update Purchase" do
    visit purchase_url(@purchase)
    click_on "Edit this purchase", match: :first

    fill_in "Billing amount", with: @purchase.billing_amount
    fill_in "Partial amount", with: @purchase.partial_amount
    fill_in "Purchase date", with: @purchase.purchase_date
    fill_in "Purchase type", with: @purchase.purchase_type
    fill_in "Store logo", with: @purchase.store_logo
    fill_in "Store name", with: @purchase.store_name
    fill_in "Verifi", with: @purchase.verifi_id
    fill_in "Verifi metadata", with: @purchase.verifi_metadata
    click_on "Update Purchase"

    assert_text "Purchase was successfully updated"
    click_on "Back"
  end

  test "should destroy Purchase" do
    visit purchase_url(@purchase)
    click_on "Destroy this purchase", match: :first

    assert_text "Purchase was successfully destroyed"
  end
end
