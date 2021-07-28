json.extract! portfolio, :id, :name, :website, :description, :start_date, :end_date, :actively_working, :created_at, :updated_at
json.url portfolio_url(portfolio, format: :json)
