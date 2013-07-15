class Dashboard 

  def select_all(query)  	
  	ActiveRecord::Base.connection.select_all(query)  
  end 	   

  def requests_summary
    select_all(" SELECT 
    	strftime('%Y-%m-%d', r.created_at) AS 'request_created_on', 
    	r.project AS 'project', 
    	rl.location_name  AS 'request_location', 
    	e.name AS 'employee', 
    	el.location_name  AS 'employee_location'
		FROM Requests r 
		LEFT OUTER JOIN Locations rl ON r.location_id = rl.id
		LEFT OUTER JOIN Selections s ON r.id = s.request_id 
		LEFT OUTER JOIN Employees e ON s.employee_id = e.id 
		LEFT OUTER JOIN Locations el ON e.location_id = el.id
		ORDER BY r.location_id, e.name DESC, r.created_at" )  
  end

  def requests_summary_by_month
    select_all(" SELECT 
		DISTINCT strftime('%Y-%m', r.created_at) AS 'Month',
		COUNT (DISTINCT r.id) AS Requests, 
		COUNT (DISTINCT rsps.request_id) AS Responses,
		COUNT (DISTINCT s.request_id) AS Selections, 
		COUNT (DISTINCT r.active) - 1  AS Cancelled 
	FROM Requests r 
	LEFT OUTER JOIN Responses rsps ON r.id = rsps.request_id 
	LEFT OUTER JOIN Selections s ON r.id = s.request_id
	WHERE Month BETWEEN strftime('%Y-%m', DATE('now','-5 months')) 
	AND strftime('%Y-%m', DATE('now'))
	GROUP BY Month
	ORDER BY Month" )
  end

  def days_to_fill
    select_all(" SELECT 
		SUM (Min_Days_to_Fill <= 1)  AS '1_Day', 
		SUM (Min_Days_to_Fill BETWEEN 1.001 AND 3) AS '1-3_Days', 
		SUM (Min_Days_to_Fill BETWEEN 3.001 AND 6) AS '3-6_Days',
		SUM (Min_Days_to_Fill > 6)  AS 'Over_6_Days'
	FROM (SELECT	  
		DISTINCT r.id, 	  
		MIN(julianday(s.created_at) - julianday(r.created_at)) AS 'Min_Days_to_Fill'	  
		FROM Selections s  
		LEFT OUTER JOIN Requests r ON s.request_id = r.id	  
		GROUP BY r.id)" )
  end

  def skill_interests
    select_all(" SELECT 
		s.name AS Skill, 
		SUM (e.location_id = 1) AS Chicago, 
		SUM (e.location_id = 2) AS Boston, 
		SUM (e.location_id = 3) AS Houston, 
		SUM (e.location_id = 4) AS 'San_Francisco', 
		SUM (e.location_id = 5) AS London, 
		SUM (e.location_id = 6) Mumbai 
	FROM Target_skills t  
	LEFT OUTER JOIN Employees e ON e.id = t.employee_id  
	LEFT OUTER JOIN Skills s ON s.id = t.skill_id 
	GROUP BY Skill " )
  end

  def average_skills
    select_all(" SELECT 
      	s.name AS Skill, 
		ROUND(AVG(CASE WHEN e.location_id=1 THEN t.level ELSE null END),1) Chicago, 
		ROUND(AVG(CASE WHEN e.location_id=2 THEN t.level ELSE null END),1) Boston, 
		ROUND(AVG(CASE WHEN e.location_id=3 THEN t.level ELSE null END),1) Houston, 
		ROUND(AVG(CASE WHEN e.location_id=4 THEN t.level ELSE null END),1) 'San_Francisco', 
		ROUND(AVG(CASE WHEN e.location_id=5 THEN t.level ELSE null END),1) London, 
		ROUND(AVG(CASE WHEN e.location_id=6 THEN t.level ELSE null END),1) Mumbai 
	FROM Target_skills t, Skills s, Employees e 
	ON t.skill_id = s.id AND t.employee_id = e.id 
	GROUP BY s.name 
	ORDER BY s.name " )
  end

  def offices_worked
    select_all(" SELECT 
		e.name AS 'Employee', 
		SUM (CASE WHEN r.location_id THEN julianday(r.start_date) BETWEEN julianday('now','-6 months') AND julianday('now','-5 months') END) AS 'To_5M_Ago', 
		SUM (CASE WHEN r.location_id THEN julianday(r.start_date) BETWEEN julianday('now','-6 months') AND julianday('now','-4 months') END) AS 'To_4M_Ago', 
		SUM (CASE WHEN r.location_id THEN julianday(r.start_date) BETWEEN julianday('now','-6 months') AND julianday('now','-3 months') END) AS 'To_3M_Ago', 
		SUM (CASE WHEN r.location_id THEN julianday(r.start_date) BETWEEN julianday('now','-6 months') AND julianday('now','-2 months') END) AS 'To_2M_Ago', 
		SUM (CASE WHEN r.location_id THEN julianday(r.start_date) BETWEEN julianday('now','-6 months') AND julianday('now','-1 month') END) AS 'To_1M_Ago', 
		SUM (CASE WHEN r.location_id THEN julianday(r.start_date) BETWEEN julianday('now','-6 month') AND julianday('now') END) AS 'Until_Today' 
	FROM Employees e 
	JOIN Selections s ON e.id = s.employee_id 
	JOIN Requests r ON r.id = s.request_id 
	GROUP BY e.name " )
  end

  def office_exchanges_6
	    select_all(" Select 
		l.location_name AS Requesting,
		SUM(e.location_id = 1) AS Chicago,
		SUM(e.location_id = 2) AS Boston,
		SUM(e.location_id = 3) AS Houston,
		SUM(e.location_id = 4) AS San_Francisco,
		SUM(e.location_id = 5) AS London,
		SUM(e.location_id = 6) AS Mumbai
	FROM Requests r
	JOIN Selections s ON r.id = s.request_id
	JOIN Employees e ON e.id = s.employee_id
	JOIN Locations l ON l.id = r.location_id
	WHERE julianday(r.start_date)>= julianday('now','-6 months') AND r.location_id != e.location_id
	GROUP BY Requesting " )
  end

  def office_exchanges_3
    select_all(" Select 
		l.location_name AS Requesting,
		SUM(e.location_id = 1) AS Chicago,
		SUM(e.location_id = 2) AS Boston,
		SUM(e.location_id = 3) AS Houston,
		SUM(e.location_id = 4) AS San_Francisco,
		SUM(e.location_id = 5) AS London,
		SUM(e.location_id = 6) AS Mumbai
	FROM Requests r
	JOIN Selections s ON r.id = s.request_id
	JOIN Employees e ON e.id = s.employee_id
	JOIN Locations l ON l.id = r.location_id
	WHERE julianday(r.start_date) BETWEEN julianday('now','-6 months') AND julianday('now','-3 months') AND r.location_id != e.location_id
	GROUP BY Requesting " )
  end

end
