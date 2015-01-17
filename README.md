TheAmazingAudioEngine meets Ruby Motion with bugs
=================================================

TheAmazingAudioEngine (TAAE) is a popular ObjC library for working
with Audio on iOS and OSX. There is one aspect of this that doesn't
quite work with RubyMotion yet.

As discussed here https://groups.google.com/forum/#!topic/rubymotion/WoAk0esOMbs
one of the methods of generating audio is to run a block of code
several thousand times a second which writes waveforms more or less
directly to the speakers. This sounds crazy, and probably is, but its
also one of the best ways to organise sample-accurate triggering of
audio files and recordings.

The problems seem to be happening with the block used as a callback.
Firstly this failed as RubyMotion wasn't able to infer the type that
the block should have. I've patched this with the code in 
`vendor/TAAERubyMotion` using the example given by Eloy Duran here:
https://gist.github.com/alloy/8452461

Now onto the second bug - the one I need help with.

The code for this app will run but crash after calling our block 512 times.
You can see this in the crashlog:

```
hread 0 Crashed:: Dispatch queue: com.apple.main-thread
0   motion-taae-test              0x000000010001eda8 +[AEBlockChannel(RubyMotionBlockTypeWrapper) channelWithBlock:] + 8 (TAAERubyMotion.m:8)
1   motion-taae-test              0x000000010001edc8 +[AEBlockChannel(RubyMotionBlockTypeWrapper) channelWithBlocklock:] + 40 (TAAERubyMotion.m:11)
2   motion-taae-test              0x000000010001edc8000000010001edc8 +[AEBlockChannel(RubyMotionBlockTypeWrapper) channelWithBlock:] + 40 (TAAERubyMotion.m:11)
3   motion-taae-test              0x000000010001edc8000000010001edc80000010001edc8 +[AEBlockChannel(RubyMotionBlockTypeWrapper) channelWithBlock:] + 40 (TAAERubyMotion.m:11)
...
509 motion-taae-test              0x000000010001edc8 +[AEBlockChannelChannel(RubyMotionBlockTypeWrapper) channelWithBlock:] + 40 (TAAERubyMotion.m:11)
510 motion-taae-test              0x000000010001edc8 +[AEBlockChannel(RubyMotionBlockTypeWrapperyMotionBlockTypeWrapper) channelWithBlock:] + 40 (TAAERubyMotion.m:11)
511 motion-taae-test              0x000000010001edc8 +[AEBlockChannel(RubyMotionBlockTypeWrapperyMotionBlockTypeWrappereWrapper) channelWithBlock:] + 40 (TAAERubyMotion.m:11)

Thread 1:: Dispatch queue: com.apple.libdispatch-manager
```

It doesn't seem to matter what happens inside the block. It can be
empty and it doesn't make a difference. Also, if you uncomment the 
NSLog in the ObjC patch you can see that the patch code is being run.

I've noticed that the crashlog seems to be saying something about `STACK GUARD`
being called for thread 0

```
Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
Exception Codes: KERN_PROTECTION_FAILURE at 0x00007fff5f3ffff8

VM Regions Near 0x7fff5f3ffff8:
    mapped file            0000000110089000-000000011020d000 [ 1552K] r--/rwx SM=COW  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/.lilid/.lilic/ymROEw3kGk
--> STACK GUARD            00007fff5bc00000-00007fff5f400000 [ 56.0M] ---/rwx SM=NUL  stack guard for thread 0
    Stack                  00007fff5f400000-00007fff5fc00000 [ 8192K] rw-/rwx SM=COW  thread 0
```

How would I go about telling RubyMotion forget about this block in 
terms of the stack trace?
