//
//  ViewController.m
//  LayerDrawingAndAnimation
//
//  Created by Anil Upadhyay on 8/13/16.
//  Copyright (c) 1816 Anil Upadhyay. All rights reserved.
//
//http://stackoverflow.com/questions/5883169/intersection-between-a-line-and-a-sphere
//http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
//http://www.ahristov.com/tutorial/geometry-games/intersection-lines.html
//http://stackoverflow.com/questions/25810045/line-circle-intersection-for-vertical-and-horizontal-lines
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (int i =0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        [btn setBackgroundColor:[UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0]];
        [self.view addSubview:btn];
        NSInteger delta = 60;
        delta += i + (arc4random_uniform(100));

        if (i == 0) {

            [btn setCenter:CGPointMake(self.view.center.x+delta, self.view.center.y+delta)];
        }
        if (i == 2) {

            [btn setCenter:CGPointMake(self.view.center.x-delta, self.view.center.y+delta)];
        }
        if (i == 1) {

            [btn setCenter:CGPointMake(self.view.center.x-delta, self.view.center.y)];
        }
        if (i == 3) {

            [btn setCenter:CGPointMake(self.view.center.x+delta, self.view.center.y-delta)];
        }
        [btn setTitle:[NSString stringWithFormat:@"%i",i] forState:UIControlStateNormal];
        btn.tag = 1000+i;
    }
    CGPoint center0 = [self.view viewWithTag:1000].center;
    CGPoint center1 = [self.view viewWithTag:1001].center;
    CGPoint center2 = [self.view viewWithTag:1002].center;
    CGPoint center3 = [self.view viewWithTag:1003].center;
    float ix;
    float iy;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center2];
    [path addLineToPoint:center3];
    circleLayer.path = [path CGPath];
    circleLayer.strokeColor = [UIColor blackColor].CGColor
    ;
    [self.view.layer addSublayer:circleLayer];
    
    circleLayer = [CAShapeLayer layer];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:center0];
    [path addLineToPoint:center1];
    circleLayer.path = [path CGPath];
    circleLayer.strokeColor = [UIColor blackColor].CGColor
    ;
    [self.view.layer addSublayer:circleLayer];
    
    
    NSLog(@"%c",get_line_intersection(center0.x, center0.y, center1.x, center1.y, center2.x, center2.y, center3.x, center3.y, &ix, &iy));
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
//    [btn setBackgroundColor:[UIColor greenColor]];
//    [btn setTitle:[NSString stringWithFormat:@"C"] forState:UIControlStateNormal];
//
//    [self.view addSubview:btn];
//    btn.center = CGPointMake(ix, iy);
    NSLog(@"%@",NSStringFromCGPoint(CGPointMake(ix, iy)));
    circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(ix, iy, 5, 5)] CGPath]];
    circleLayer.strokeColor = [UIColor greenColor].CGColor
    ;
    circleLayer.fillColor = [UIColor greenColor].CGColor
    ;
    circleLayer.bounds = CGRectMake(circleLayer.frame.size.width/2, circleLayer.frame.size.height/2, 5, 5);
    [self.view.layer addSublayer:circleLayer];
    
    
    NSLog(@"%i",collision_circle_line(self.view.center.x, self.view.center.y, 10, center0.x, center0.y,center1.x, center1.y));
    circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.center.x, self.view.center.y, 10, 10)] CGPath]];
    circleLayer.strokeColor = [UIColor yellowColor].CGColor
    ;
    circleLayer.fillColor = [UIColor yellowColor].CGColor
    ;
    [self.view.layer addSublayer:circleLayer];
    
    
    circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(center0.x, center0.y, 10, 10)] CGPath]];
    circleLayer.strokeColor = [UIColor yellowColor].CGColor
    ;
    circleLayer.fillColor = [UIColor yellowColor].CGColor
    ;
    circleLayer.bounds = CGRectMake(circleLayer.frame.size.width/2, circleLayer.frame.size.height/2, 10, 10);
    [self.view.layer addSublayer:circleLayer];
    
    circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(center1.x, center1.y, 10, 10)] CGPath]];
    circleLayer.strokeColor = [UIColor purpleColor].CGColor
    ;
    circleLayer.fillColor = [UIColor purpleColor].CGColor
    ;
    circleLayer.bounds = CGRectMake(circleLayer.frame.size.width/2, circleLayer.frame.size.height/2, 10, 10);
    [self.view.layer addSublayer:circleLayer];
    

    circleLayer = [CAShapeLayer layer];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center0.x, center0.y)];
    [path addLineToPoint:center1];
    circleLayer.path = [path CGPath];
    circleLayer.strokeColor = [UIColor blueColor].CGColor
    ;
    [self.view.layer addSublayer:circleLayer];
    
    
    

}
char get_line_intersection(float p0_x, float p0_y, float p1_x, float p1_y,
                           float p2_x, float p2_y, float p3_x, float p3_y, float *i_x, float *i_y)
{
    float s1_x, s1_y, s2_x, s2_y;
    s1_x = p1_x - p0_x;     s1_y = p1_y - p0_y;
    s2_x = p3_x - p2_x;     s2_y = p3_y - p2_y;
    
    float s, t;
    s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
    t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);
    
    if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
    {
        // Collision detected
        if (i_x != NULL)
            *i_x = p0_x + (t * s1_x);
        if (i_y != NULL)
            *i_y = p0_y + (t * s1_y);
        return 1;
    }
    
    return 0; // No collision
}
/*
public static Point3D[] FindLineSphereIntersections( Point3D linePoint0, Point3D linePoint1, Point3D circleCenter, double circleRadius )
{
    // http://www.codeproject.com/Articles/19799/Simple-Ray-Tracing-in-C-Part-II-Triangles-Intersec
    
    double cx = circleCenter.X;
    double cy = circleCenter.Y;
    double cz = circleCenter.Z;
    
    double px = linePoint0.X;
    double py = linePoint0.Y;
    double pz = linePoint0.Z;
    
    double vx = linePoint1.X - px;
    double vy = linePoint1.Y - py;
    double vz = linePoint1.Z - pz;
    
    double A = vx * vx + vy * vy + vz * vz;
    double B = 2.0 * (px * vx + py * vy + pz * vz - vx * cx - vy * cy - vz * cz);
    double C = px * px - 2 * px * cx + cx * cx + py * py - 2 * py * cy + cy * cy +
    pz * pz - 2 * pz * cz + cz * cz - circleRadius * circleRadius;
    
    // discriminant
    double D = B * B - 4 * A * C;
    
    if ( D < 0 )
    {
        return new Point3D[ 0 ];
    }
    
    double t1 = ( -B - Math.Sqrt ( D ) ) / ( 2.0 * A );
    
    Point3D solution1 = new Point3D( linePoint0.X * ( 1 - t1 ) + t1 * linePoint1.X,
                                    linePoint0.Y * ( 1 - t1 ) + t1 * linePoint1.Y,
                                    linePoint0.Z * ( 1 - t1 ) + t1 * linePoint1.Z );
    if ( D == 0 )
    {
        return new Point3D[] { solution1 };
    }
    
    double t2 = ( -B + Math.Sqrt( D ) ) / ( 2.0 * A );
    Point3D solution2 = new Point3D( linePoint0.X * ( 1 - t2 ) + t2 * linePoint1.X,
                                    linePoint0.Y * ( 1 - t2 ) + t2 * linePoint1.Y,
                                    linePoint0.Z * ( 1 - t2 ) + t2 * linePoint1.Z );
    
    // prefer a solution that's on the line segment itself
    
    if ( Math.Abs( t1 - 0.5 ) < Math.Abs( t2 - 0.5 ) )
    {
        return new Point3D[] { solution1, solution2 };
    }
    
    return new Point3D[] { solution2, solution1 };
}
 */
bool collision_circle_line(double Cx, double Cy,double r,double x1,double y1,double x2,double y2) {
    double dx = x2 - x1;
    double dy = y2 - y1;
    
    double sx = x1 - Cx;
    double sy = y1 - Cy;
    
    double tx = x2 - Cx;
    double ty = y2 - Cy;
    
    if (tx*tx + ty*ty < r*r) return true;
    
    double c = sx*sx + sy*sy - r*r;
    if (c < 0) return true;
    
    double b = 2 * (dx * sx + dy * sy);
    double a = dx*dx + dy*dy;
    
    if (abs(a) < 1.0e-12) return false;
    
    double discr = b*b - 4*a*c;
    if (discr < 0) return false;
    discr = sqrt(discr);
    
    double k1 = (-b - discr) / (2 * a);
    if (k1 >= 0 && k1 <= 1) return true;
    
    double k2 = (-b + discr) / (2 * a);
    if (k2 >= 0 && k2 <= 1) return true;
    
    return false;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionForCenterButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self createPathForbuttons:@[_blueButton]];
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
  
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = (UIView *)params[0];
        view.alpha = 1.0;
        CGPoint anchorPoint = CGPointFromString(params[1]);
        CGRect backupFarm = view.frame;
        view.transform = CGAffineTransformMakeScale(0, 0);
        CGPoint topCenter = CGPointMake(CGRectGetMidX(view.frame), CGRectGetMinY(view.frame));
//        view.layer.anchorPoint = CGPointMake(0.5, 0);


        [UIView animateWithDuration:1.5 delay:0 options:0 animations:^{

                             view.transform = CGAffineTransformMakeScale(1, 1);
                    view.layer.position = topCenter;
                         }completion:^(BOOL finished) {

                         }];

    });
}
@end
