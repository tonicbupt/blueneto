//
//  XBTViewController.h
//  XBlueTooth
//
//  Created by tonic on 14-6-9.
//  Copyright (c) 2014年 tonic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface XBTViewController : UIViewController<CBPeripheralDelegate, CBCentralManagerDelegate>

@property (nonatomic, readonly) CBCentralManager *manager;
@property (nonatomic) NSMutableArray *devices;

@property (nonatomic) UIButton *button;

@end
