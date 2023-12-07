#
#  Be sure to run `pod lib lint CausalFoundrySDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "CausalFoundrySDK"
  s.version      = "0.0.1"
  s.summary      = "CausalFoundry SDK"
  s.description  = "CausalFoundry SDK Description"
  s.homepage     = "https://github.com/causalfoundry/ios-sdk"
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
  s.author       = { "Developer" => "moiz@causalfoundry.ai" }
  s.platform     = :ios, "13.0"
  s.source       = { :git => "https://github.com/causalfoundry/ios-sdk", :branch => 'develop' }
  s.source_files =  "CHWManagement/Sources/**/*.swift", "Core/Sources/**/*.swift", "E_Commerce/Sources/**/*.swift", "E_Learning/Sources/**/*.swift", "Frameworks/**/*.xcframework", "Loyalty/Sources/**/*.swift", "Payments/Sources/**/*.swift"
  s.exclude_files = "Package.swift", "build.sh", "CHWManagement/Tests", "Core/Tests", "E_Commerce/Tests", "E_Learning/Tests", "Loyalty/Tests", "Payments/Testst"
  s.requires_arc = true
  s.swift_version= '5.4'
  s.vendored_frameworks = 'Frameworks/MMKV.xcframework'
end
