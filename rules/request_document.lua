priority: 3
input_parameter: "request"
events_table: ["request_document_html"]

request.method == "GET"
and #request.path_segments == 2
and request.path_segments[1]:match("^[%a-]+$") -- TODO: make it a known type, not just any word
and uuid.check(request.path_segments[2])
and request.headers["accept"]:match("html")

