
Pod::Spec.new do |s|
  s.name             = 'XHPermanentThread'
  s.version          = '0.2.0'
  s.summary          = '线程保活'
  s.homepage         = 'https://github.com/CoderMrUku/XHPermanentThread'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderMrUku' => 'houyue10@qq.com' }
  s.source           = { :git => 'https://github.com/CoderMrUku/XHPermanentThread.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'XHPermanentThread/Classes/**/*'
end
