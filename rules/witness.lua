priority: 2
input_parameter: "request"
events_table: ["witness_html"]

request.method == "GET"
and #request.path_segments == 0
and uuid.check(request.query.witness)
