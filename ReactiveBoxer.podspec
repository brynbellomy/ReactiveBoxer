#
# ReactiveBoxer
# CocoaPods podspec
#

Pod::Spec.new do |s|
    s.platform     = :ios, '5.1'
    s.name         = 'ReactiveBoxer'
    s.version      = '0.0.2'
    s.author       = { 'bryn austin bellomy' => 'bryn.bellomy@gmail.com' }
    s.summary      = 'Reactive Cocoa + MGBox = unthinkably easy, dynamically-bound iOS layouts.'
    s.homepage     = 'http://github.com/brynbellomy/ReactiveBoxer'
    s.license      = { :type => 'WTFPL', :file => 'LICENSE.md' }

    s.source       = { :git => 'https://github.com/brynbellomy/ReactiveBoxer.git', :tag => "v#{s.version.to_s}" }
    s.source_files = "Classes/*.{h,m}"

    s.requires_arc = true

    s.dependency 'MGBox2'

    s.dependency 'libextobjc/EXTScope', '>= 0.2.5'
    s.dependency 'ObjectiveSugar'
    s.dependency 'ReactiveCocoa', '>= 1.8.0'

    s.dependency 'BrynKit/Main'               , '>= 1.2.5'
    s.dependency 'BrynKit/RACHelpers'         , '>= 1.2.5'
    s.dependency 'BrynKit/GCDThreadsafe'      , '>= 1.2.5'
    s.dependency 'BrynKit/MGBoxHelpers'       , '>= 1.2.5'
    s.dependency 'BrynKit/EDColor'            , '>= 1.2.5'
    s.dependency 'BrynKit/CocoaLumberjack'    , '>= 1.2.5'


end







