
Pod::Spec.new do |s|

  s.name         = "BXAppKit-BXLoadMoreControl"
  s.version      = "1.0.0"
  s.summary      = "Pure-Swift iOS Application Library BXLoadMoreControl"

  s.description  = <<-DESC
                  Pure-Swift iOS Application Library BXLoadMoreControl, with CocoaPods Support
                   DESC

  s.homepage     = "https://github.com/banxi1988/BXAppKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "banxi1988" => "banxi1988@gmail.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/banxi1988/BXAppKit.git", :branch => 'master' }

  s.source_files  = ["BXLoadMoreControl/**/*.swift" ]

  #s.dependency ''

  s.requires_arc = true
  s.module_name = "BXLoadMoreControl"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.1' }
end
