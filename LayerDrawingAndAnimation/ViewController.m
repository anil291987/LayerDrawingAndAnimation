//
//  ViewController.m
//  LayerDrawingAndAnimation
//
//  Created by Anil Upadhyay on 8/13/16.
//  Copyright (c) 2016 Anil Upadhyay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionForCenterButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self createPathForbuttons:@[_blueButton,_orangeButton,_magentoButton]];
    }else{
        
    }
}
- (CAShapeLayer *)createShapeLayer:(UIBezierPath *)bPath {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [bPath CGPath];
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 2.0;
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    return shapeLayer;
}

- (CABasicAnimation *)createAnimationForShapeLayer {
    //Animation Path
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    theAnimation.duration = 1.5f;
    theAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    theAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    theAnimation.removedOnCompletion = YES;

    return theAnimation;
}

-(void)createPathForbuttons:(NSArray *)buttons{
    for (UIButton *button in buttons) {

        UIBezierPath *bPath = [UIBezierPath bezierPath];
        [bPath moveToPoint:CGPointMake(_centerButton.center.x - _centerButton.frame.size.width/2, _centerButton.center.y - _centerButton.frame.size.height/2)];
        CGPoint anchorPoint;
        if (button == _blueButton) {
            anchorPoint = CGPointMake(button.center.x - button.frame.size.width/2, button.center.y + button.frame.size.height/2);
            [bPath addLineToPoint:anchorPoint];
        }else{
            [bPath addLineToPoint:CGPointMake(button.center.x + button.frame.size.width/2, button.center.y + button.frame.size.height/2)];
        }
        
        CAShapeLayer *shapeLayer;
        shapeLayer = [self createShapeLayer:bPath];
        [self.view.layer addSublayer:shapeLayer];
        
        CABasicAnimation *theAnimation;
        theAnimation = [self createAnimationForShapeLayer];
        [shapeLayer addAnimation:theAnimation forKey:@"strokeEnd"];


        [self performSelector:@selector(makeVisibleView:) withObject:@[button,NSStringFromCGPoint(anchorPoint)] afterDelay:1.5];
        
    }
    
}
-(void)makeVisibleView:(NSArray *)params{
    UIView *view = (UIView *)params[0];
    CGPoint anchorPoint = CGPointFromString(params[1]);
    CGRect backupFarm = view.frame;
    view.frame = CGRectMake(anchorPoint.x+10,anchorPoint.y-5,0, 0) ;
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         view.alpha = 1.0;
                         view.frame = backupFarm;

                     }completion:^(BOOL finished) {
                         if (finished) {
                             view.hidden = NO;
                         }
                     }];
}
@end
