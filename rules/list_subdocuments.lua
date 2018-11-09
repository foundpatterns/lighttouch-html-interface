priority: 3
input_parameter: "request"
events_table: ["list_subdocuments_html"]

request.method == "GET"
and #request.path_segments == 3
and request.path_segments[1]:match("^%a+$") -- TODO: make it a known type, not just any word
and uuid.check(request.path_segments[2])
and request.path_segments[3]:match("^%a+$") -- TODO: make it a known type, not just any word
and request.headers["accept"]:match("html")

