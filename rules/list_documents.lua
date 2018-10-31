priority: 3
input_parameter: "request"

if request.method == "GET"
and #request.path_segments == 1
and request.path_segments[1]:match("^%a+$") -- TODO: make it a known type, not just any word
and request.headers["accept"]:match("html")
then
    events["list_documents_html"]:trigger(request)
end
