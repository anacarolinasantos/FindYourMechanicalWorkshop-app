platform :ios, '12.0'

target 'FindYourCarWorkshop' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  
  plugin 'cocoapods-keys', {
    :project => "FindYourCarWorkshop",
    :target => "FindYourCarWorkshop",
    :keys => [
      "GoogleApiKey"
    ]
  }

  # Pods for FindYourCarWorkshop
    pod 'Moya', '~> 13.0'
    pod 'GooglePlaces', '~> 3.2.0'
    pod 'GoogleMaps', '~> 3.2.0'
    pod 'Reusable', '~> 4.0.2'

  target 'FindYourCarWorkshopTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'Fakery'
  end

  target 'FindYourCarWorkshopUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
