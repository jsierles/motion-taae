class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'motion-taae-test'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    @audio = AEAudioController.alloc.initWithAudioDescription(
      AEAudioController.nonInterleaved16BitStereoAudioDescription,
      inputEnabled:false)

    @audio.start(nil)

    metronome_block_channel = AEBlockChannel.channelWithBlock(lambda do |time, frames, audio|
        p time
    end)

    @audio.addChannels([metronome_block_channel])    
    true
  end
end
