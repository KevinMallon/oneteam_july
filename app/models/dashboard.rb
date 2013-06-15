class Dashboard 

  def requests_summary
    ActiveRecord::Base.connection.select_all " SELECT strftime('%Y-%m-%d', r.created_at) AS 'request_created_on', r.project AS 'project', rl.location_name  AS 'request_location', e.name AS 'employee', el.location_name  AS 'employee_location'"\
		" FROM Requests r "\
		" LEFT OUTER JOIN Locations rl ON r.location_id = rl.id"\
		" LEFT OUTER JOIN Selections s ON r.id = s.request_id "\
		" LEFT OUTER JOIN Employees e ON s.employee_id = e.id "\
		" LEFT OUTER JOIN Locations el ON e.location_id = el.id"\
		" ORDER BY r.location_id, e.name DESC, r.created_at"   
  end

  def requests_summary_by_month
      ActiveRecord::Base.connection.select_all " SELECT "\
			" DISTINCT strftime('%Y-%m', r.created_at) AS 'Month',"\
			" COUNT (DISTINCT r.id) AS Requests, "\
			" COUNT (DISTINCT rsps.request_id) AS Responses,"\
			" COUNT (DISTINCT s.request_id) AS Selections, "\
			" COUNT (DISTINCT r.active) - 1  AS Cancelled "\
		" FROM Requests r "\
		" LEFT OUTER JOIN Responses rsps ON r.id = rsps.request_id "\
		" LEFT OUTER JOIN Selections s ON r.id = s.request_id"\
		" WHERE Month BETWEEN strftime('%Y-%m', DATE('now','-5 months')) "\
		" AND strftime('%Y-%m', DATE('now'))"\
		" GROUP BY Month"\
		" ORDER BY Month"
  end

end
