Pod::Spec.new do |s|
  s.name         = "CausalFoundrySDKCore"
  s.version      = "1.1.12"
  s.summary      = "Causal Foundry Core SDK"
  s.description  = "Causal Foundry Core SDK (https://docs.causalfoundry.ai/)"
  s.homepage     = "https://docs.causalfoundry.ai/"
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
  s.author       = { "Developer" => "dev@causalfoundry.ai" }
  s.platform     = :ios, "12.0"
  s.source       = { :git => "https://github.com/causalfoundry/ios-sdk.git", :tag => s.version.to_s }
  
  ios_deployment_target = '12.0'
  s.ios.deployment_target = ios_deployment_target
  s.prefix_header_file = false
  
  s.source_files = "CausalFoundrySDKCore/Sources/**/*.swift", "Frameworks/**/*.xcframework"
  s.exclude_files = "CausalFoundrySDKCore/Tests/**/*"
  
  s.framework = 'Foundation'
  s.ios.framework = 'UIKit'

  s.platforms        = { :ios => '12.0' }
  s.swift_version    = '5.0'
  s.vendored_frameworks = "Frameworks/MMKV.xcframework"
end
