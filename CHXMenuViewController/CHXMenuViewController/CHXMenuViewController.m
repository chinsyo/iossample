//
//  CHXMenuViewController.m
//  CHXMenuViewController
//
//  Created by 王晨晓 on 16/3/22.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXMenuViewController.h"
#import "CHXTableView.h"
#import "CHXCollectionView.h"

#ifdef __COMMON__INIT__
    #undef __COMMON__INIT__
#endif
#define __COMMON__INIT__ \
    [self setupProperty];\
    [self setupMenu];\
    [self setupAnimation];\

#define MAINSCREENWIDTH ([UIScreen mainScreen].bounds.size.width)
#define MAINSCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

static const CGFloat kCHXNavigationBarHeight = 64.f;
static const CGFloat kCHXStatusBarHeight = 20.f;

@interface CHXMenuViewController () <UICollisionBehaviorDelegate>
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;

@property (nonatomic, assign) CGFloat oldAngle;
@property (nonatomic, assign) CGFloat newAngle;
@property (nonatomic, assign, getter=isSupportBoundry) BOOL supportBoundry;
@property (nonatomic, assign, getter=isFirstPresented) BOOL firstPresented;
@end

@implementation CHXMenuViewController

+ (instancetype)menuWithControllers:(NSArray<UIViewController *> *)controllers menuTitles:(NSArray<NSString *> *)menuTitles imageTitles:(NSArray<NSString *> *)imageTitles {
    return [[CHXMenuViewController alloc] initWithControllers:controllers menuTitles:menuTitles imageTitles:imageTitles];
}

+ (instancetype)menuWithControllers:(NSArray<UIViewController *> *)controllers menuTitles:(NSArray<NSString *> *)menuTitles imageTitles:(NSArray<NSString *> *)imageTitles style:(CHXMenuStyle)style {
    return [[CHXMenuViewController alloc] initWithControllers:controllers menuTitles:menuTitles imageTitles:imageTitles style:style];
}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers menuTitles:(NSArray<NSString *> *)menuTitles imageTitles:(NSArray<NSString *> *)imageTitles {
    return [self initWithControllers:controllers menuTitles:menuTitles imageTitles:imageTitles style:CHXMenuStyleTable];
}

- (instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers menuTitles:(NSArray<NSString *> *)menuTitles imageTitles:(NSArray<NSString *> *)imageTitles style:(CHXMenuStyle)style {
    self = [[CHXMenuViewController alloc] init];
    if (self) {
        self.controllers = [controllers mutableCopy];
        self.menuTitles = [menuTitles mutableCopy];
        self.imageTitles = [imageTitles mutableCopy];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        __COMMON__INIT__
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        __COMMON__INIT__
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __COMMON__INIT__
    }
    return self;
}

- (void)setupProperty {
    self.oldAngle = 0.f;
    self.newAngle = 0.f;
    self.firstPresented = NO;
    self.supportBoundry = NO;
    self.state = CHXMenuStateOpened;
    self.menuColor = [UIColor orangeColor];
}

- (void)setupMenu {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(switchMenuState)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, MAINSCREENWIDTH, MAINSCREENHEIGHT)];
    self.menuView.backgroundColor = self.menuColor;
    self.menuView.alpha = 0.0;
    [self.view addSubview:self.menuView];
}

- (void)setupAnimation {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
    
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.menuView]];
    itemBehavior.elasticity = 0.5f;
    itemBehavior.resistance = 1.2f;
    itemBehavior.allowsRotation = YES;
    [self.animator addBehavior:itemBehavior];
    
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.menuView]];
    self.collisionBehavior.collisionDelegate = self;
    [self.collisionBehavior addBoundaryWithIdentifier:@"Collide End" fromPoint:CGPointMake(-2, MAINSCREENHEIGHT/2.0) toPoint:CGPointMake(-2, MAINSCREENHEIGHT)];
    [self.collisionBehavior addBoundaryWithIdentifier:@"Collide Start" fromPoint:CGPointMake(MAINSCREENHEIGHT/2,-MAINSCREENWIDTH + kCHXNavigationBarHeight) toPoint:CGPointMake(MAINSCREENHEIGHT, -MAINSCREENWIDTH + kCHXNavigationBarHeight)];
    [self.animator addBehavior:self.collisionBehavior];

    CGPoint puntoAncoraggio = CGPointMake((kCHXNavigationBarHeight/2.0),(kCHXNavigationBarHeight/2.0));
    UIOffset offset = UIOffsetMake(-self.view.bounds.size.width/2 + puntoAncoraggio.x , -self.view.bounds.size.height/2 + puntoAncoraggio.y);
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.menuView offsetFromCenter:offset attachedToAnchor:puntoAncoraggio];
    [self.animator addBehavior:attachmentBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.menuView] mode:UIPushBehaviorModeContinuous];
    CGVector vector = CGVectorMake(1000, 0);
    pushBehavior.pushDirection = vector;
    UIOffset offsetPush = UIOffsetMake(0, MAINSCREENHEIGHT/2);
    [pushBehavior setTargetOffsetFromCenter:offsetPush forItem:self.menuView];
    [self.animator addBehavior:pushBehavior];
    
    __weak typeof (self) weakSelf = self;
    self.collisionBehavior.action = ^() {
        CGFloat radians = atan2(weakSelf.menuView.transform.b, weakSelf.menuView.transform.a);
        CGFloat degrees = radians * (180 / M_PI );
        weakSelf.newAngle = radians;
        
        if (!weakSelf.isFirstPresented) {
            weakSelf.newAngle = -M_PI_2;
            CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotation.duration = 0.001;
            rotation.autoreverses = NO;
            rotation.removedOnCompletion = NO;
            rotation.fillMode = kCAFillModeForwards;
            rotation.fromValue = [NSNumber numberWithFloat: weakSelf.oldAngle];
            rotation.toValue = [NSNumber numberWithFloat: weakSelf.newAngle];
            [weakSelf.menuButton.layer addAnimation: rotation forKey: @"rotation"];

        } else if (weakSelf.newAngle != weakSelf.oldAngle) {
            
            CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotation.duration = 0.01;
            rotation.autoreverses = NO;
            rotation.removedOnCompletion = NO;
            rotation.fillMode = kCAFillModeForwards;
            rotation.fromValue = [NSNumber numberWithFloat: weakSelf.oldAngle];
            rotation.toValue = [NSNumber numberWithFloat: weakSelf.newAngle];
            [weakSelf.menuButton.layer addAnimation: rotation forKey: @"rotation"];

            weakSelf.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:1.0 alpha:((-degrees)/90)]};
        }
        weakSelf.oldAngle = weakSelf.newAngle;
    };
}

- (void)addMenuItemWithController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image {
    [self.controllers addObject:controller];
    [self.menuTitles addObject:title];
    [self.imageTitles addObject:image];
}

- (void)openMenu {

    if ([self.delegate respondsToSelector:@selector(menuWillOpen)]) {
        [self.delegate performSelector:@selector(menuWillOpen)];
    }

    [UIView animateWithDuration:0.15 animations:^{
        if (self.style == CHXMenuStyleCollection)
            self.collectionView.alpha = 1.0;
        else
            self.tableView.alpha = 1.0;
    } completion:NULL];
    
    [self.collisionBehavior removeBoundaryWithIdentifier:@"Collide Right"];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.menuView]];
    [self.animator addBehavior:gravity];
    self.supportBoundry = NO;
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.menuView] mode:UIPushBehaviorModeContinuous];
    CGVector vectorOpen = CGVectorMake(0, 2200.0);
    pushBehavior.pushDirection = vectorOpen;
    [self.animator addBehavior:pushBehavior];
    
    self.state = CHXMenuStateOpened;
    if ([self.delegate respondsToSelector:@selector(menuDidOpen)]) {
        [self.delegate performSelector:@selector(menuDidOpen)];
    }
}

- (void)closeMenu {

    if ([self.delegate respondsToSelector:@selector(menuWillClose)]) {
        [self.delegate performSelector:@selector(menuWillClose)];
    }
    
    UIPushBehavior *pushOpen;
    [self.animator removeBehavior:pushOpen];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.menuView] mode:UIPushBehaviorModeInstantaneous];
    CGVector vector = CGVectorMake(800, 100);
    pushBehavior.pushDirection = vector;
    UIOffset pushOffset = UIOffsetMake(0, MAINSCREENHEIGHT/2);
    [pushBehavior setTargetOffsetFromCenter:pushOffset forItem:self.menuView];
    [self.animator addBehavior:pushBehavior];
    
    self.state = CHXMenuStateClosed;
    if ([self.delegate respondsToSelector:@selector(menuDidClose)]) {
        [self.delegate performSelector:@selector(menuDidClose)];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(nonnull id<UIDynamicItem>)item withBoundaryIdentifier:(nullable id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSString *identifierString = [NSString stringWithFormat:@"%@", identifier];
    if ([identifierString isEqualToString:@"Collide Start"]) {
        
        if (!self.supportBoundry) {
            float offsetBounce = 0.0;
            [self.collisionBehavior addBoundaryWithIdentifier:@"Collide Right" fromPoint:CGPointMake(MAINSCREENHEIGHT/2, kCHXNavigationBarHeight + offsetBounce) toPoint:CGPointMake(MAINSCREENHEIGHT, kCHXNavigationBarHeight + offsetBounce)];
            self.supportBoundry = YES;
        }
        
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.menuView.alpha = 1.0;
        } completion:NULL];
        
        UIPushBehavior *pushInit;
        [self.animator removeBehavior:pushInit];
        self.state = CHXMenuStateClosed;
        
        if (!self.isFirstPresented) {
            self.firstPresented = YES;
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            if (self.style == CHXMenuStyleCollection)
                self.collectionView.alpha = 0.0;
            else
                self.tableView.alpha = 0.0;
        } completion:NULL];
    }
};

- (void)switchMenuState {
    if (self.state) {
        [self closeMenu];
    } else {
        [self openMenu];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    switch (self.style) {
        case CHXMenuStyleTable: {
            self.tableView = [[CHXTableView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.tableView];
        }
            break;
            
        case CHXMenuStyleCollection: {
            self.collectionView = [[CHXCollectionView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.collectionView];
        }
            break;
    }
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navigationBar.translucent = YES;
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    UIImage *background = [UIImage imageNamed:@"nav_background"];
    [navigationBar setBackgroundImage:background forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];

    self.currentController = self.controllers[0];
    self.navigationItem.title = self.menuTitles[0];
}

- (void)setCurrentController:(UIViewController * _Nonnull)currentController {

    [self addChildViewController:currentController];
    [self.view insertSubview:currentController.view belowSubview:self.view];
    currentController.view.frame = self.view.frame;
    
    _currentController = currentController;
    [currentController didMoveToParentViewController:self];
}

@end
