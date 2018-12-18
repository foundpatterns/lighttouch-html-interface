priority = 3
input_parameter = "request"
events_table = ["request_document_edit_form"]

request.method == "GET"
and #request.path_segments == 3
and models[request.path_segments[1]]
and uuid.check(request.path_segments[2])
and request.path_segments[3] == "edit"
