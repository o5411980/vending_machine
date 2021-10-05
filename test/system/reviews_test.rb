require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  setup do
    @review = reviews(:one)
  end

  test "visiting the index" do
    visit reviews_url
    assert_selector "h1", text: "Reviews"
  end

  test "creating a Review" do
    visit reviews_url
    click_on "New Review"

    fill_in "Comment", with: @review.comment
    fill_in "Date on", with: @review.date_on
    fill_in "Deadline", with: @review.deadline
    fill_in "Description", with: @review.description
    fill_in "Former review", with: @review.former_review
    check "Judge" if @review.judge
    fill_in "Requester", with: @review.requester
    fill_in "Stage", with: @review.stage
    click_on "Create Review"

    assert_text "Review was successfully created"
    click_on "Back"
  end

  test "updating a Review" do
    visit reviews_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @review.comment
    fill_in "Date on", with: @review.date_on
    fill_in "Deadline", with: @review.deadline
    fill_in "Description", with: @review.description
    fill_in "Former review", with: @review.former_review
    check "Judge" if @review.judge
    fill_in "Requester", with: @review.requester
    fill_in "Stage", with: @review.stage
    click_on "Update Review"

    assert_text "Review was successfully updated"
    click_on "Back"
  end

  test "destroying a Review" do
    visit reviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Review was successfully destroyed"
  end
end
