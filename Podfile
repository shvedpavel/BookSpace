# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test
  pod 'FolioReaderKit', git:'https://github.com/evilutioner/FolioReaderKit.git'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['JSQWebViewController'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
