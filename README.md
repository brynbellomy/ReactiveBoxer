

# // ReactiveBoxer

[ReactiveCocoa](http://github.com/ReactiveCocoa/ReactiveCocoa) + [MGBox2](http://github.com/sobri909/MGBox2) = good shit

# how

Start with the simplest things.  Let's make a method that spits out an `MGLine`
for a given object in our data model.  Actually, it'll yield a `RACLine`, a
direct subclass of `MGLine` (albeit with reactive functionality baked right in).

Our example line will have some text to the left and a `UIImageView` on the right.
These elements will change automatically in response to any changes in the model
object that produce KVO notifications.

```objective-c
- (RACLine *) createLineForCrashedUFO:(CrashedUFO *)ufo
{
    RACSignal *signal_imageView =
        [[RACAbleWithStart(ufo, crewIsAlive)
               onMainThreadScheduler]
               mapFromBool: ^id (BOOL crewIsAlive) {
                   return [[UIImageView alloc] initWithImage: (crewIsAlive
                                                                  ? [UIImage imageNamed:@"surviving-crew"]
                                                                  : [UIImage imageNamed:@"dead-crew"])];
               }];


    RACSignal *signal_text  = [RACAbleWithStart(ufo, crashLocationString) onMainThreadScheduler];

    RACLine *line = [RACLine lineWithLeftSignal: signal_text
                                    rightSignal: signal_imageView
                                           size: CGSizeMake(320.0f, 50.0f)];

    // some regular MGBox2 appearance fiddling, just to show that you can do this the same way with the `RAC...` subclasses
    line.font      = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f];
    line.padding = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [line layout];

    return line;
}
```

Now let's create a table.  It'll contain a line for each object in our data model.

For now, let's pretend that our data model is just a plain old `NSArray`.  This is
a shitty way of doing things, because it means we will only get KVO updates (which
trigger the reactive behavior built into the `RAC...` UI components) when someone
does something as clumsy as `self.crashedUFOArray = @[ ... ]`.  But don't worry --
hooking **ReactiveBoxer** up with more complex database code is a snap.

```objective-c
- (RACTableBox *) initializeCrashedUFOTableBox
{
    @weakify(self);

    RACSignal *signal_tableData =
        [[RACAble(self.crashedUFOArray)
                        deliverOn: [RACScheduler scheduler]]
                        map:^NSArray* (NSArray *crashedUFOArray) {

                            NSArray *lines = [[[[crashedUFOArray.rac_sequence.signal
                                                    onMainThreadScheduler]
                                                    map:^RACLine* (CrashedUFO *ufo) {
                                                        @strongify(self);
                                                        RACLine *line = [self createLineForCrashedUFO:ufo];
                                                        return line;
                                                    }]
                                                    deliverOn: [RACScheduler scheduler]]
                                                    toArray];

                            return lines;
                        }];

    RACTableBox *box_list = [RACTableBox boxWithTopLinesSignal: signal_tableData
                                             middleLinesSignal: nil
                                             bottomLinesSignal: nil
                                                          size: self.view.size];

    return box_list;
}
```

Easy and fluent.

And now let's say you have this `RACTableBox` inside a `RACScrollView` so that
users can scroll up and down once there are too many `CrashedUFO` objects to
fit on a single screen.

Actually, the only thing you need to do is ensure that the `RACScrollView`'s
`-layoutWithSpeed:completion:` method (inherited from its `MGBox` class lineage)
is called whenever its sub-box, the `RACTableBox`, finishes its own
`-layoutWithSpeed:completion:` call.

To do this, we'll subscribe to the `signal_didUpdateContents` property on our
`RACTableBox` and use it to fire the `-layoutWithSpeed:` selector on the `RACScrollView`.

```objective-c
    RACTableBox *box_list = [self initializeCrashedUFOTableBox];

    RACSignal *signal_layoutScroller = [[[box_list signal_didUpdateContents]
                                                   // this value becomes the 'speed' parameter
                                                   // in `layoutWithSpeed:completion:'
                                                   mapReplace:@0.3f] 
                                                   onMainThreadScheduler];

    //
    // self.box_scroller is a RACScrollView
    // 
    [self.box_scroller.boxes addObject: box_list];
    [self.box_scroller rac_liftSelector: @selector(bryn_layoutWithSpeed:)
                            withObjects: signal_layoutScroller];

```

Note: `bryn_layoutWithSpeed:` is a category method bridging ReactiveCocoa's
abstraction with MGBox's `layoutWithSpeed:completion:` method.  It will be
moved into **ReactiveBoxer**'s namespace eventually.

