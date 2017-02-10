Pod::Spec.new do |s|
  s.name         = "XMPPFramework"
  s.version      = "3.6.5"
  s.summary      = "An XMPP Framework in Objective-C for Mac and iOS"
  s.homepage     = "https://github.com/We-Conect/XMPPFramework"
  s.license      = "MIT (example)"
  s.author             = { "we.CONECT Global Leaders GmbH" => "marc.jeanson@we-conect.com" }
  s.platform     = :ios
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/We-Conect/XMPPFramework.git", :branch => "patch-ipv6" }
  s.resources = [ '**/*.{xcdatamodel,xcdatamodeld}']

  s.description = 'XMPPFramework provides a core implementation of RFC-3920 (the xmpp standard), along with
  the tools needed to read & write XML. It comes with multiple popular extensions (XEPs),
  all built atop a modular architecture, allowing you to plug-in any code needed for the job.
  Additionally the framework is massively parallel and thread-safe. Structured using GCD,
  this framework performs    well regardless of whether it\'s being run on an old iPhone, or
  on a 12-core Mac Pro. (And it won\'t block the main thread... at all).'

  s.osx.deployment_target = '10.8'
  s.ios.deployment_target = '7.0'


  s.requires_arc = true
  s.default_subspec = "All"

  # XMPPFramework.h is used internally in the framework to let modules know
  # what other optional modules are available. Since we don't know yet which
  # subspecs have been selected, include all of them wrapped in defines which
  # will be set by the relevant subspecs.

  s.prepare_command = <<-'END'
  echo '#import "XMPP.h"' > XMPPFramework.h
  grep '#define _XMPP_' -r /Extensions \
  | tr '-' '_' \
  | perl -pe 's/Extensions\/([A-z0-9_]*)\/([A-z]*.h).*/\n#ifdef HAVE_XMPP_SUBSPEC_\U\1\n\E#import "\2"\n#endif/' \
  >> XMPPFramework.h
  END

  s.subspec 'Core' do |core|
    core.source_files = ['XMPPFramework.h', 'Core/**/*.{h,m}', 'Vendor/libidn/*.h', 'Authentication/**/*.{h,m}', 'Categories/**/*.{h,m}', 'Utilities/**/*.{h,m}']
    core.vendored_libraries = 'Vendor/libidn/libidn.a'
    core.libraries = 'xml2', 'resolv'
    core.xcconfig = {
      'HEADER_SEARCH_PATHS' => '$(inherited) $(SDKROOT)/usr/include/libxml2 $(SDKROOT)/usr/include/libresolv',
      'LIBRARY_SEARCH_PATHS' => '$(PODS_ROOT)/XMPPFramework/Vendor/libidn',
      'ENABLE_BITCODE' => 'NO'
    }
    core.dependency 'CocoaLumberjack', '~> 1.9'
    core.dependency 'CocoaAsyncSocket', '~> 7.4.1'
  end

  s.subspec 'All' do |ss|
    ss.dependency 'XMPPFramework/Core'
    ss.dependency 'XMPPFramework/BandwidthMonitor'
    ss.dependency 'XMPPFramework/CoreDataStorage'
    ss.dependency 'XMPPFramework/FileTransfer'
    ss.dependency 'XMPPFramework/GoogleSharedStatus'
    ss.dependency 'XMPPFramework/ProcessOne'
    ss.dependency 'XMPPFramework/Reconnect'
    ss.dependency 'XMPPFramework/Roster'
    ss.dependency 'XMPPFramework/XEP-0009'
    ss.dependency 'XMPPFramework/XEP-0012'
    ss.dependency 'XMPPFramework/XEP-0016'
    ss.dependency 'XMPPFramework/XEP-0045'
    ss.dependency 'XMPPFramework/XEP-0054'
    ss.dependency 'XMPPFramework/XEP-0059'
    ss.dependency 'XMPPFramework/XEP-0060'
    ss.dependency 'XMPPFramework/XEP-0065'
    ss.dependency 'XMPPFramework/XEP-0066'
    ss.dependency 'XMPPFramework/XEP-0077'
    ss.dependency 'XMPPFramework/XEP-0082'
    ss.dependency 'XMPPFramework/XEP-0085'
    ss.dependency 'XMPPFramework/XEP-0092'
    ss.dependency 'XMPPFramework/XEP-0100'
    ss.dependency 'XMPPFramework/XEP-0106'
    ss.dependency 'XMPPFramework/XEP-0115'
    ss.dependency 'XMPPFramework/XEP-0136'
    ss.dependency 'XMPPFramework/XEP-0147'
    ss.dependency 'XMPPFramework/XEP-0153'
    ss.dependency 'XMPPFramework/XEP-0172'
    ss.dependency 'XMPPFramework/XEP-0184'
    ss.dependency 'XMPPFramework/XEP-0191'
    ss.dependency 'XMPPFramework/XEP-0198'
    ss.dependency 'XMPPFramework/XEP-0199'
    ss.dependency 'XMPPFramework/XEP-0202'
    ss.dependency 'XMPPFramework/XEP-0203'
    ss.dependency 'XMPPFramework/XEP-0223'
    ss.dependency 'XMPPFramework/XEP-0224'
    ss.dependency 'XMPPFramework/XEP-0280'
    ss.dependency 'XMPPFramework/XEP-0297'
    ss.dependency 'XMPPFramework/XEP-0308'
    ss.dependency 'XMPPFramework/XEP-0333'
    ss.dependency 'XMPPFramework/XEP-0335'
  end

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.frameworks = "UIKit", "Foundation"
end
