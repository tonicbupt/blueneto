//
//  XBTViewController.m
//  XBlueTooth
//
//  Created by tonic on 14-6-9.
//  Copyright (c) 2014年 tonic. All rights reserved.
//

#import "XBTViewController.h"

@interface XBTViewController ()

@end

@implementation XBTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dispatch_queue_t centralQueue = dispatch_queue_create("central", DISPATCH_QUEUE_SERIAL);
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue];
    _devices = [[NSMutableArray alloc] init];
    
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setTitle:@"点击搜索设备" forState:UIControlStateNormal];
    [_button setFrame:CGRectMake(50, 200, 100, 30)];
    [_button setTag:1001];
    [_button addTarget:self
                action:@selector(buttonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma button ui

- (void)buttonClicked: (UIButton*)sender
{
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30.0 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [_manager stopScan];
    });
}

#pragma bluetooth

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // connected
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    // discovered
    NSLog(@"device found, with name: %@", [peripheral name]);
    [_devices addObject:peripheral];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch ([central state]) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙已经开启");
            break;
            
        default:
            break;
    }
}

@end
