require 'common_mob'
require 'tempfile'


class AptSource < AngryMob::Target
  include CommonMob::ShellHelper

  default_action
  def add_source
    run_target 'file', list_file, :string => args.source

    add_key if args.key_url? && args.key_uid?

    sh("apt-get update -qy").run
  end


  def add_key
    # TODO check for key first
 
    file = Tempfile.new('am-apt-source-key')

    sh("curl #{ args.key_url } -o #{ file.path } && apt-key add #{ file.path }").run
  ensure
    file.close!
  end


  protected
  alias_method :name, :default_object


  def state
    {
      :rand => rand()
    }
  end


  def has_key?
  end


  def list_file
    Pathname("/etc/apt/sources.list.d/#{ name }.list")
  end
end


