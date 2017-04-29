# -*- coding: utf-8 -*-
from string import Template
import codecs

mod_list = [
    'PinAuto',
    'BXModel',
    'BXiOSUtils',
    'BXForm',
    'BXHUD',
    'BXModule',
    'BXLoadMoreControl',
    'BXCityPicker',
    'BXViewPager'
]

project_version = '1.0.0'

podspec_tpl = """
Pod::Spec.new do |s|

  s.name         = "${pod_name}"
  s.version      = "${version}"
  s.summary      = "Pure-Swift iOS Application Library ${mod_name}"

  s.description  = <<-DESC
                  Pure-Swift iOS Application Library ${mod_name}, with CocoaPods Support
                   DESC

  s.homepage     = "https://github.com/banxi1988/BXAppKit"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "banxi1988" => "banxi1988@gmail.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/banxi1988/BXAppKit.git", :branch => 'master' }

  s.source_files  = ["${mod_name}/**/*.swift" ]

  #s.dependency ''

  s.requires_arc = true
  s.module_name = "${mod_name}"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.1' }
end
"""

def create_podspec(mod_name):
    pod_name = "BXAppKit-%s" % mod_name
    tpl = Template(podspec_tpl)
    pod_content = tpl.substitute({
        "mod_name": mod_name,
        "pod_name": pod_name,
        "version": project_version
    })
    spec_filename = "%s.podspec" % pod_name
    with codecs.open(spec_filename,mode='w', encoding='utf-8') as fout:
        fout.write(pod_content)

def init_pods():
    for mod_name in mod_list:
        create_podspec(mod_name)

def new_pod(mod_name):
    create_podspec(mod_name)


if __name__ == '__main__':
    import sys
    argv_str = ''.join(sys.argv[1:])
    if 'init_pods' in argv_str:
        init_pods()
    elif 'new_pod' in argv_str:
        new_pod(argv[2])
    else:
        print("unknow command")



