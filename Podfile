source 'https://github.com/CocoaPods/Specs'

platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

abstract_target 'Common' do
  pod 'Dollar'
  pod 'R.swift'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'ReSwift'
  pod 'Sourcery'
  pod 'SwiftLint'
  pod 'Swinject'

  target 'Data' do
    pod 'Apollo'
  end

  target 'PokeApp' do
    pod 'Kingfisher'
    pod 'Layout'
    pod 'MaterialComponents/ActivityIndicator'
    pod 'MaterialComponents/Buttons+ButtonThemer'
    pod 'MaterialComponents/NavigationBar'
    pod 'SwiftyColor'
    pod 'UICollectionViewLeftAlignedLayout'
  end

  target 'Tests' do
    pod 'Nimble'
  end
end
