module CommonMob
  class ResourceLocator
    def resource(target,name)
      path = target.act.definition_file.to_s.sub(/\.([^\.]+)$/,'')
      (path.pathname + name.to_s)
    end
    alias_method :[], :resource
  end
end
