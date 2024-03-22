#
# Be sure to run `pod lib lint Docker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Docker'
  s.version          = '1.4.0'
  s.summary          = 'Docker handle in some easy steps all connections with your remote servers. Offers you some classes to call Web Services defining http method, request, response, .... and some classes to handle resources download.'

  s.homepage         = 'https://github.com/SysdataSpA/Docker'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.author           = { 'Sysdata S.p.A.' => 'team.mobile@sysdata.it' }
  s.source           = { :git => 'https://github.com/SysdataSpA/Docker.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  # s.resource_bundles = {
  #   'Docker' => ['Docker/Assets/*.png']
  # }

  s.subspec 'Core' do |co|
co.source_files = 'Docker/Classes/**/*'
    co.dependency 'AFNetworking/Reachability', '~> 2.6.0'
    co.dependency 'AFNetworking/Serialization', '~> 2.6.0'
    co.dependency 'AFNetworking/Security', '~> 2.6.0'
    co.dependency 'AFNetworking/NSURLSession', '~> 2.6.0'
    co.dependency 'AFNetworking/NSURLConnection', '~> 2.6.0'
    co.dependency 'Mantle'
  end


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.subspec 'Blabber' do |bl|
     bl.dependency 'Docker/Core'
     bl.dependency 'Blabber'
     bl.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'BLABBER=1' }
  end

  s.default_subspec = 'Core'

end
