# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def sortable(column, max, min, search, title = nil)
    title ||= column.titleize
    direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    if search.nil?
      link_to title, { sort: column, direction: direction, max: min, min: max },
              id: column.to_s, class: 'btn btn-outline-dark'
    else

      link_to title, search_categories_path( sort: column, direction: direction, max: min, min: max, product_name: search),
              id: column.to_s, class: 'btn btn-outline-dark'
    end
  end
end
