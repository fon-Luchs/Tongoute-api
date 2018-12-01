module HeaderMerger
  def merge_headers(headers)
    request.headers.merge! headers
  end
end