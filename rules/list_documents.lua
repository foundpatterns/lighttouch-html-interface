priority: 3
input_parameter: "request"
events_table: ["list_documents_html"]

request.method == "GET"
and #request.path_segments == 1
and request.path_segments[1]:match("^%a+$") -- TODO: make it a known type, not just any word
and request.headers["accept"]:match("html")

