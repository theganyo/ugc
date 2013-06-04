require 'io/console'

desc 'Performs a login to the current profile'
arg_name 'username'

command :login do |c|

  c.switch [:a,:admin]
  c.flag [:p,:password]
  c.action do |global_options,options,args|

    help_now! unless args[0]

    password = options[:password] || ask('password: ') { |q| q.echo = '*' }

    if password
      if options[:admin]
        management = Ugc::Management.new
        management.login args[0], password
      else
        application = Ugc::Application.new
        application.login args[0], password
      end
    end
    puts "logged in user: #{args[0]}"
  end
end
