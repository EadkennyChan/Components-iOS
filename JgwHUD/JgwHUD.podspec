Pod::Spec.new do |s|
    s.name         = "JgwHUD"
    s.authors      = "Eadkennychan"
    s.version      = "0.0.1"
    s.summary      = "公共提示页"
    s.description  = "公共提示页，SVProgressHUD 2.1.2版本上封装"
    s.homepage     = "https://github.com/EadkennyChan/"
    s.license      = { :type => "MIT", :text => "LICENSE"}
    s.author       = { "Eadkennychan" => "Eadkennychan@gmail.com" }
    s.source           = { :git => 'https://github.com/EadkennyChan/iflyMSC.git', :tag => s.version.to_s }

    s.requires_arc = true
    s.platform     = :ios
    s.ios.deployment_target = '8.0'

    s.source_files = 'Classes/{*,**/*}.{h,m}'
    s.frameworks = 'AVFoundation','SystemConfiguration','Foundation','CoreTelephony','AudioToolbox','UIKit','CoreLocation','Contacts','AddressBook','QuartzCore','CoreGraphics'
    s.prefix_header_contents = ['#import "SVProgressHUD.h"']
    s.dependency 'SVProgressHUD'
end
