
//
//  Bluetooth.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import CoreBluetooth


internal let BluetoothManager = CBPeripheralManager(delegate: Permission.Bluetooth, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey:false])
