Pod::Spec.new do |s|
  s.name     = "KJExtensionHandler"
  s.version  = "1.1.1"
  s.summary  = "77 ExtensionHandler"
  s.homepage = "https://github.com/yangKJ/KJExtensionHandler"
  s.license  = "MIT"
  s.license  = {:type => "MIT", :file => "LICENSE"}
  s.license  = "Copyright (c) 2020 yangkejun"
  s.author   = {"77" => "ykj310@126.com"}
  s.platform = :ios
  s.source   = {:git => "https://github.com/yangKJ/KJExtensionHandler.git",:tag => "#{s.version}"}
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true

  s.default_subspec  = 'Kit'
  s.ios.source_files = 'KJExtensionHandler/KJExtensionHeader.h'
  s.resources = "README.md"

  s.subspec 'Kit' do |y|
    y.source_files = "KJExtensionHandler/Kit/**/*.{h,m}"
    y.public_header_files = 'KJExtensionHandler/Kit/*.h',"KJExtensionHandler/Kit/**/*.h"
    y.frameworks = 'Accelerate'
  end

  s.subspec 'Foundation' do |fun|
    fun.source_files = "KJExtensionHandler/Foundation/**/*.{h,m}"
    fun.public_header_files = 'KJExtensionHandler/Foundation/*.h',"KJExtensionHandler/Foundation/**/*.h"
    fun.dependency 'KJExtensionHandler/Kit'
  end
  
  s.subspec 'Language' do |la|
    la.source_files = "KJExtensionHandler/Language/**/*.{h,m}"
    la.public_header_files = 'KJExtensionHandler/Language/*.h',"KJExtensionHandler/Language/**/*.h"
    la.dependency 'KJExtensionHandler/Kit'
  end
  
  s.subspec 'Opencv' do |op|
    op.source_files = "KJExtensionHandler/Opencv/**/*"
    op.dependency 'KJExtensionHandler/Kit'
  end
  
end
