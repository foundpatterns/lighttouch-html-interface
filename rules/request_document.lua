priority: 3
if request.method == "GET"
and #request.path_segments == 2
and request.path_segments[1]:match("^%a+$") -- TODO: make it a known type, not just any word
and uuid.check(request.path_segments[2])
and request.headers["accept"]:match("html")
then
    events["request_document_html"]:trigger(request)
end
