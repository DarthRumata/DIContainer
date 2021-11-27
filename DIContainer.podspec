Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "DIContainer"
  spec.version      = "0.0.1"
  spec.summary      = "Dependency Injection library based on Swinject ideas"

  spec.description  = <<-DESC
  Dependency Injection library based on Swinject ideas
                   DESC

  spec.homepage     = "https://github.com/DarthRumata/DIContainer"
  spec.license      = { :type => "MIT", :file => "License" }
  spec.author = { "Stanislav Kirichok" => "kirichok.stas@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.ios.deployment_target = "11.0"
  spec.osx.deployment_target = "10.10"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/DarthRumata/DIContainer.git", :branch => 'master'}  #:tag => spec.version }
  spec.source_files  = "Source/**/*.{swift}"

  spec.test_spec do |test_spec|
    test_spec.source_files = 'Tests/**/*.{swift}'
  end

end
