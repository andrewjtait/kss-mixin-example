namespace :kss do
  desc "Generates sass for kss examples"
  task :generate_sass do
    path = "app/assets/stylesheets/kss/tmp"
    # remove any existing sass files
    FileUtils.rm_rf(Dir.glob("#{path}/*"))

    # create new kss parser
    styleguide = Kss::Parser.new("app/assets/stylesheets")
    sections = styleguide.sections

    sections.each do |section|
      section = section[1]
      # find sections which are mixins
      if section.type.start_with?('@') && section.usage.length > 0
        content = ""
        klass_prefix = section.section.gsub('.','-')
        # create file
        file = "#{path}/_#{klass_prefix}.css.scss"
        # loop through all usage examples
        section.usage.each_with_index do |use,index|
          klass = klass_prefix + "-#{index}"

          content << <<-SASS
            .#{klass} { #{ use } }
          SASS
        end

        File.open(file, "w+") do |f|
          f.write(content)
        end

        puts "Generated Sass file: #{file}"
      end
    end
  end
end
