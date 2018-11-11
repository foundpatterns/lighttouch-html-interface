priority: 2
input_parameter: "request"
events_table: ["get_document_form", "http_auth"]

request.method == "GET"
and #request.path_segments == 2
and request.path_segments[1]:match("^[%a-]+$") -- TODO: make it a known type, not just any word
and request.path_segments[2] == "new"
