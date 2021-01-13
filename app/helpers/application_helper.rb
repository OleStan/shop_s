# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def sortable(column, max, min, title = nil)
    title ||= column.titleize
    direction = params[:direction] == "asc" ? "desc" : "asc"
    link_to title, sort: column, direction: direction, max: min, min: max
  end
end
