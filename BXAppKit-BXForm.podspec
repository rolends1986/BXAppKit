
Pod::Spec.new do |s|

  s.name         = "BXAppKit-BXForm"
  s.version      = "1.0.0"
  s.summary      = "Pure-Swift iOS Application Library BXForm"

  s.description  = <<-DESC
                  Pure-Swift iOS Application Library BXForm, with CocoaPods Support
                   DESC

  s.homepage     = "https://github.com/banxi1988/BXAppKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "banxi1988" => "banxi1988@gmail.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/banxi1988/BXAppKit.git", :branch => 'master' }

  s.source_files  = ["BXForm/**/*.swift" ]

  s.dependency 'BXAppKit-BXModel'
  s.dependency 'BXAppKit-PinAuto'
  s.dependency 'BXAppKit-BXiOSUtils'

  s.requires_arc = true
  s.module_name = "BXForm"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.1' }
end
