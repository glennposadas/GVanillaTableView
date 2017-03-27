project 'GVanillaTableView/GVanillaTableView.xcodeproj'

platform :ios, '9.0'
use_frameworks!

  target 'GVanillaTableView' do
    
    pod 'Alamofire'
    pod 'AlamofireImage', '~> 3.1'
    pod 'Kingfisher', '~> 3.0'
    pod 'SwiftyJSON'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
        
    end

  end

  target 'GVanillaTableViewTests' do

  end

  target 'GVanillaTableViewUITests' do

  end
