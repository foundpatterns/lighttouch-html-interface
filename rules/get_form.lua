priority: 2
if request.method == "GET"
and #request.path_segments == 2
and request.path_segments[1]:match("^%a+$") -- TODO: make it a known type, not just any word
and request.path_segments[2] == "new"
then
  events["http_auth"]:trigger(request)
  events["get_document_form"]:trigger(request)
end
