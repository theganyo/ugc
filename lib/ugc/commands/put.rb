desc 'idempotent create or update (usually an update)'
arg_name 'url [data]'

command :put,:update do |c|
  c.flag [:d,:data], :desc => 'does nothing: for ease of conversion from curl'
  c.flag [:f,:file], :must_match => /=/, :arg_name => 'field_name=file_name', :desc => 'will force multipart upload'

  c.action do |global_options,options,args|
    help_now! unless args[0]

    resource = $context[args[0]]
    payload = parse_data(options[:data] || args[1])
    if options[:file]
      format_response multipart_upload resource, payload, options[:file], :put
    else
      format_response resource.put payload
    end
  end

end
