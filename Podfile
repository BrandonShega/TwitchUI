# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TwitchUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TwitchUI

  target 'TwitchUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TwitchUIUITests' do
    # Pods for testing
  end

end

plugin 'cocoapods-keys', {
  project: 'TwitchUI',
  target: 'TwitchUI',
  keys: [
    'TwitchAPIClientID',
    'TwitchAPIClientSecret'
  ]
}
