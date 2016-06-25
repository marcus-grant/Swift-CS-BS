//
//  AppDelegate.swift
//  sort-tester
//
//  Created by Marcus Grant on 6/24/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    let sc = SortController()
    //var testArray: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    //var testArray: [Int] = [1,2,3,4,5,6,7,8,9]
    //sc.shuffleInPlace(&testArray)
    var testArray = sc.createTestArrayWith(10000, minValue: 0, maxValue: 99)
    var bubbleSortArray = testArray
    var quickSortArray = testArray
    var combSortArray = testArray
    //print("Shuffled Array:   \(testArray)")
//    print("Performing Bubble-Sort!")
//    let bubbleStats = sc.bubbleSortWithStats(&bubbleSortArray)
    var outputString = "BubbleSort completed with "
//    outputString += "\(bubbleStats.compares) comparisons, "
//    outputString += "\(bubbleStats.arrayAccesses) accesses, "
//    outputString += "and finished in \(bubbleStats.time)ms"
//    print (outputString)
//    print("Performing Comb-sort!")
//    let combStats = sc.combSortWithStats(&combSortArray, gapScaleFactor: 1.3)
//    outputString = "CombSort completed with "
//    outputString += "\(combStats.compares) comparisons, "
//    outputString += "\(combStats.arrayAccesses) accesses, "
//    outputString += "and finished in \(combStats.time)ms"
//    print (outputString)
    let trials = 10
//    print("Performing \(trials) trials of Comb-Sort...")
//    let combSortStats = sc.testCombSortWithInts(trials, size: 10000, gapScale: 1.3, minValue: 0, maxValue: 1000)
//    print("All the Comb-Sort trials ended with these stats:")
//    print("worst time:   \(combSortStats.maxTime)")
//    print("average time: \(combSortStats.avgTime)")
//    print("best time:    \(combSortStats.minTime)")

    print("Performing gap sweep of comb-sort...")
    let size = 10000
    let minGap = 1.1
    let maxGap = 8.0
    let sweepRate = 0.1
    let combSweepResults = sc.testCombSortWithGapSweep(trials, size: size,
                                                       minGap: minGap,
                                                       maxGap: maxGap,
                                                       sweepRate: sweepRate)
    print ("Sweep completed, here are the results:")
    var currentGap = minGap
    for avgTime in combSweepResults {
      print("gapScale: \(currentGap), sort time: \(avgTime)")
      currentGap += sweepRate
    }



    //print ("                 " + sc.arrayStringWithIndex(testArray))
//    print("Beginning Bubble Sort!")
//    let bubbleStartTime = NSDate()
//    sc.bubbleSort(&bubbleSortArray)
//    let bubbleSortTime = -1 * bubbleStartTime.timeIntervalSinceNow
//    print("Bubble Sorted: Array: \(bubbleSortArray)")
//    print("Bubble Sort took \(bubbleSortTime*1000)ms")
//    print("Beginning QuickSort!")
//    let quickStartTime = NSDate()
//    sc.quickSort(&quickSortArray)
//    let quickSortTime = -1 * quickStartTime.timeIntervalSinceNow
//    print("Quick Sorted Array \(quickSortArray)")
//    print("Quick sort took \(quickSortTime*1000)ms")
    //print("Here's merge sort")

    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

