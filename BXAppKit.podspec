Pod::Spec.new do |s|
  s.name = "BXAppKit"

  s.version = '1.0'

  s.source = {
    :git => "https://github.com/banxi1988/#{s.name}.git",
    :branch => 'master',
    :submodules => true
  }

  s.license = 'MIT'
  s.homepage = "https://github.com/banxi1988/#{s.name}"
  s.summary = 'BXAppKit 应用常用库及框架集合'
  s.description = 'BXAppKit 是一个用于方便 iOS 的 常用库的集合, 包含 PinAuto,BXModel,BXForm,BXViewPager,BXiOSUtils等 多个实用库'
  s.authors  = { 'banxi1988' => 'banxi1988@gmail.com' }
  s.default_subspecs = 'BXModel','BXiOSUtils', 'PinAuto', 'BXForm'
  s.requires_arc = true

  s.ios.deployment_target = '9.0'

  s.subspec 'PinAuto' do |ss|
    ss.ios.source_files =  'PinAuto/*'
  end

  s.subspec 'BXModel' do |ss|
    ss.ios.source_files =  'BXModel/*'
    ss.dependency 'SwiftyJSON', '~> 3.1.4'
  end

  s.subspec 'BXModule' do |ss|
    ss.ios.source_files =  'BXModule/*'
  end

  s.subspec 'BXiOSUtils' do |ss|
    ss.ios.source_files =  'BXiOSUtils/*'
    ss.dependency 'DynamicColor', '~> 3.2.1'
  end

  s.subspec 'BXHUD' do |ss|
    ss.ios.source_files =  'BXHUD/*'
    ss.dependency 'BXAppKit/PinAuto'
  end

  s.subspec 'BXForm' do |ss|
    ss.ios.source_files =  'BXForm/*'
    ss.dependency 'BXAppKit/PinAuto'
    ss.dependency 'BXAppKit/BXModel'
    ss.dependency 'BXAppKit/BXiOSUtils'
  end

  s.subspec 'BXCityPicker' do |ss|
    ss.ios.source_files =  'BXCityPicker/*'
    ss.dependency 'BXAppKit/BXForm'
  end

  s.subspec 'BXViewPager' do |ss|
    ss.ios.source_files =  'BXViewPager/*'
    ss.dependency 'BXAppKit/BXForm'
  end

  s.subspec 'BXLoadMoreControl' do |ss|
    ss.ios.source_files =  'BXLoadMoreControl/*'
    ss.dependency 'BXAppKit/PinAuto'
  end

end