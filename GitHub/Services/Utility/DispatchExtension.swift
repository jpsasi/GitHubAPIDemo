//
//  DispatchExtension.swift
//  GitHub
//
//  Created by Sasikumar JP on 12/02/16.
//  Copyright © 2016 Sasikumar JP. All rights reserved.
//

import Foundation

func runAfterDelayInMainQueue(delayTime: Double, block: () -> ()) {
    runAfterDelay(delayTime, dispatchQueue: dispatch_get_main_queue(), block: block)
}

func runAfterDelay(delayTime: Double, dispatchQueue: dispatch_queue_t, block: () -> ()) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayTime * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatchQueue, {
        block()
    })
}

func runInQueue(queue: dispatch_queue_t, block: () -> ()) {
    dispatch_async(queue, block)
}

func runInBackgroundQueue(block: () -> ()) {
    let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
    dispatch_async(backgroundQueue, block)
}

func runInMainQueue(block: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), block)
}
