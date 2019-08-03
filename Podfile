# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FindYourMechanicalWorkshop' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  plugin 'cocoapods-keys', {
    :project => "FindYourMechanicalWorkshop",
    :target => "FindYourMechanicalWorkshop",
    :keys => [
      "GoogleApiKey"
    ]
  }

  # Pods for FindYourMechanicalWorkshop
    pod 'Moya', '~> 13.0'
    pod 'GooglePlaces', '~> 3.2.0'
    pod 'GoogleMaps', '~> 3.2.0'

  target 'FindYourMechanicalWorkshopTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FindYourMechanicalWorkshopUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
