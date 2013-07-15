module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "OneTeam"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def current_employee=(employee)
    @current_employee = employee
  end

  def current_employee
    @current_employee ||= 
    Employee.find_by_remember_token(cookies[:remember_token])
  end

  def current_employee?(employee)
    employee == current_employee
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
    link_to link_text, link_path
    end
  end

end