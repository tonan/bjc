module DeliverySugar
  module DSL
    def build_cookbook_changed?
      build_changes = changed_files.select do |changed_file|
        changed_file.match(%r{^#{build_cookbook_path}})
      end

      build_changes.compact.any?
    end

    def build_cookbook_path
      delivery_config_path = File.join(delivery_workspace_repo, ".delivery", "config.json")
      @build_cookbook_path ||= JSON.parse(IO.read(delivery_config_path))['build_cookbook']['path']
    end
  end
end
