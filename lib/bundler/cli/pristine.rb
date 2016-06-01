# frozen_string_literal: true
module Bundler
  class CLI::Pristine
    attr_reader :options, :gem_list
    def initialize(options, gem_list)
      @options = options
      @gem_list = gem_list
    end

    def run
      # Determine if there are any conflict groups
      if !gem_list.empty? && !options[:skip].empty?
        conflicting_gems = options[:skip] & gem_list
        unless conflicting_gems.empty?
          Bundler.ui.error "You can't list a gem in both GEMLIST and --skip." \
          "The offending gems are: #{conflicting_gems.join(", ")}."
          exit 1
        end
      end
      # Determine if -extensions and --no-extensions or  are conflict
      if options[:extensions] && options["no-extensions"]
        Bundler.ui.error "You can't use --extensions and --no-extensions at the same time"
        exit 1
      end
      # Determine if --all and gem list is provided
      if options[:all] && !gem_list.empty?
        Bundler.ui.error "You can't use --all and specify gem list at the same time"
        exit 1
      end
      # Check if we should pristine all gems
      definition = Bundler.definition
      # Find the path gems and exclude them from calling gem pristine
      path_gems , git_gems, pristine_gems = []
      if gem_list.empty?
        sources = definition.sources
        if sources.git_sources.empty? && sources.path_sources.empty?
          # We can call gem pristine on every gem using lockfile
        else
          # Exclude those in git_sources path_sources
        end
      else
        pristine_gems = gem_list.dup
      end
        # pristine only the gem_list ones

      Bundler.ui.warn("Options are#{options}, gem name are #{gem_list}")
    end
  end
end
