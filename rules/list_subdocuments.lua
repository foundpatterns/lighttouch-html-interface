priority = 3
input_parameter = "request"
events_table = ["list_subdocuments_html"]

request.method == "GET"
and #request.path_segments == 3
and models[request.path_segments[1]]
and uuid.check(request.path_segments[2])
and models[request.path_segments[3]]
and request.headers["accept"]:match("html")
