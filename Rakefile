require 'mharris_ext'

def ec(cmd)
  puts cmd
  puts `#{cmd}`
end

def build_templates
  File.create "lib/templates.js",""
  Dir["src/templates/*.handlebars"].each do |f|
    name = File.basename(f).split(".").first
    body = File.read(f).gsub("\n"," ")
    File.append "lib/templates.js","Em.TEMPLATES['#{name}'] = Em.Handlebars.compile('#{body}');\n\n"
  end
end

task :build do
  ec "rm -rf lib"
  ec "coffee -o lib/ -c src/"
  ec "coffee -o test/ -c test_coffee/"
  ec "cp -r src/*.js lib"
  ec "rm -rf lib/vendor"
  ec "cp -r vendor lib"
  build_templates
end

task :test => :build do
  exec "npm test"
end

task :dist => :build do
  ec "browserify lib/main.js > dist/ember-pagination.js"
end

def ec_popen(cmd)
  IO.popen(cmd) do |io|
    while res = io.read(1)
      print res
    end
  end
end

app_name = "ember-pagination"
namespace :overlay do
  def build(npm)
    root = File.expand_path(File.dirname(__FILE__))
    app = "#{root}/test_overlay_app"
    ec "rm -rf #{app}"
    ec "fs_template #{root}/test_overlay #{root}/test_overlay_app"
    raise 'bad' unless $?.success?
    Dir.chdir(app) do
      if npm
        ec "npm install"
      end
      ec "bower install"
    end
  end
  task :build_inner do
    build(true)
  end

  task :copy_dist => [:dist] do
    root = File.expand_path(File.dirname(__FILE__))
    source = "#{root}/dist/#{app_name}.js"
    target = "#{root}/test_overlay_app/vendor/#{app_name}/index.js"

    ec "rm #{target}"
    ec "cp #{source} #{target}"
  end

  task :build => [:build_inner,:copy_dist]

  task :test => [:dist,:build,:test_inner]

  task :test_inner do
    app = File.expand_path(File.dirname(__FILE__) + "/test_overlay_app")
    ec_popen "cd #{app} && grunt test:ci"
  end

  def with_dir_put_back(dir)
    tmp = File.expand_path(File.dirname(__FILE__)) + "/putback_#{rand(10000000000000)}"
    ec "mv #{dir} #{tmp}"
    yield
  ensure
    ec "mv #{tmp} #{dir}"
  end

  task :build_quick do
    root = File.expand_path(File.dirname(__FILE__))

    with_dir_put_back "#{root}/test_overlay_app/node_modules" do
      build(false)
    end
  end
end
