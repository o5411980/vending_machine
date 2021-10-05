json.extract! review, :id, :requester, :stage, :description, :former_review, :date_on, :deadline, :judge, :comment, :created_at, :updated_at
json.url review_url(review, format: :json)
