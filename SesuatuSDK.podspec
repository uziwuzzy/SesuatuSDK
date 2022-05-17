Pod::Spec.new do |s|

s.name             = "SesuatuSDK"
s.version          = "0.1.0"
s.summary          = "a pure swift library compatible with obj-c and swift"
s.homepage         = "https://github.com/uziwuzzy/SesuatuSDK"
s.license          = 'MIT'
s.author           = { "uziwuzzy" => "https://github.com/uziwuzzy/"}
s.source           = { :git => "https://github.com/uziwuzzy/SesuatuSDK", :tag => s.version}
s.platform     = :ios
s.requires_arc = true
s.ios.deployment_target  = "13.0"
s.dependency "RxAlamofire"
s.dependency "NeedleFoundation"
s.dependency "SnapKit"

end