# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motion-taae-test'
  app.pods do
    pod 'TheAmazingAudioEngine', git: "https://github.com/TheAmazingAudioEngine/TheAmazingAudioEngine"
  end

  taae_patch = File.expand_path(File.join(File.dirname(__FILE__), "./vendor/TAAERubyMotion"))
  app.vendor_project(taae_patch, :static, :bridgesupport_cflags => "-I#{Dir.pwd}/vendor/Pods/Headers", :cflags => "-I#{Dir.pwd}/vendor/Pods/Headers")
end
