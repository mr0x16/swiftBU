//
//  AppDelegate.swift
//  swiftTest
//
//  Created by bocom on 16/1/23.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var strDate = NSString()
    var pTran = paramsTrans()
    let urlHead = "http://out.bitunion.org/open_api/"
    var grpList = [groupCell]()
    var homePostList = [postCell]()
//    var threadPostList = [postCell]()
    var frmList = NSMutableDictionary()
    var subList = NSMutableDictionary()
    var currFrmId:String = ""
    var image : UIImage?
//    var currentVc = ViewController()
//    var request:Request
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        self.login()
//        let VC=ContainerViewController()
        let VC = richTextViewController()
//        let navigationC=UINavigationController(rootViewController: VC)
//        navigationC.navigationBar.backgroundColor = UIColor(red: 51/255, green: 165/255, blue: 252/255, alpha: 1.0)
        self.window?.rootViewController=VC
        self.window?.backgroundColor=UIColor.clearColor()
        
        // Override point for customization after application launch.
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
        self.logout()?.responseJSON{ response in
            if response.result.isSuccess {
                let body = response.result.value as! NSDictionary
                if body.valueForKey("result") as! String == "success"{
                    NSLog("Logout success!")
                } else {
                    NSLog("Logout failure!")
                }
            } else {
                NSLog("Logout failure!")
            }
        }
        NSLog("App has terminate!")
    }
    // MARK: - 其他方法
    func getFrmCell() -> (forumName: String, subArray: NSArray){
        let cell = frmList.valueForKey(currFrmId) as! forumCell
        return (cell.frmName, cell.subArray)
    }
    
    // MARK: - 接口请求
    func login() ->Request? {
        let username = self.pTran.paramsGet("userName")
        let password = self.pTran.paramsGet("passWord")
        NSLog("username is \(username)")
        NSLog("password is \(password)")
        
        let urlStr = urlHead + "bu_logging.php"
        NSLog(urlStr)
        return Alamofire.request(.POST,urlStr,parameters:["action":"login","username":username,"password":password],encoding:ParameterEncoding.JSON )
    }
    
    func listForum() ->Request? {
        let username = self.pTran.paramsGet("userName")
        let session = self.pTran.paramsGet("session")
        NSLog("username is \(username)")
        NSLog("session is \(session)")
        
        let urlStr = urlHead + "bu_forum.php"
        NSLog(urlStr)
        return Alamofire.request(.POST,urlStr,parameters:["action":"forum","username":username,"session":session],encoding:ParameterEncoding.JSON )
    }
    
    func getUserInfo() ->Request? {
        let username = self.pTran.paramsGet("userName")
        let session = self.pTran.paramsGet("session")
        let uid = self.pTran.paramsGet("uid")
        NSLog("username is \(username)")
        NSLog("session is \(session)")
        
        let urlStr = urlHead + "bu_profile.php"
        NSLog(urlStr)
        return Alamofire.request(.POST,urlStr,parameters:["action":"profile","username":username,"session":session,"uid":uid],encoding:ParameterEncoding.JSON )
    }
    
    func listPosts(begin:Int, end:Int) ->Request? {
        let username = self.pTran.paramsGet("userName")
        let session = self.pTran.paramsGet("session")
        let urlStr = urlHead + "bu_thread.php"
        return Alamofire.request(.POST,urlStr,parameters:["action":"thread","username":username,"session":session,"fid":self.currFrmId,"from":"\(begin)","to":"\(end)"],encoding:ParameterEncoding.JSON )
    }
    
    
    func indexPost() ->Request? {
        let username = self.pTran.paramsGet("userName")
        let session = self.pTran.paramsGet("session")
        let urlStr = urlHead + "bu_home.php"
        return Alamofire.request(.POST,urlStr,parameters:["username":username,"session":session],encoding:ParameterEncoding.JSON )
    }
    
    func listDetail(tid:String, begin:Int, end:Int) ->Request? {
        let username = self.pTran.paramsGet("userName")
        let session = self.pTran.paramsGet("session")
        let urlStr = urlHead + "bu_post.php"
        return Alamofire.request(.POST,urlStr,parameters:["action":"post","username":username,"session":session,"tid":tid,"from":"\(begin)","to":"\(end)"],encoding:ParameterEncoding.JSON )
    }
    
    func logout() ->Request? {
        let username = self.pTran.paramsGet("userName")
        let password = self.pTran.paramsGet("passWord")
        let session = self.pTran.paramsGet("session")
        let urlStr = urlHead + "bu_logging.php"
        return Alamofire.request(.POST,urlStr,parameters:["action":"logout","username":username,"password":password,"session":session],encoding:ParameterEncoding.JSON )
    }
    // MARK: - 增删改查
    func addData(name: String, key: String) {
        
        let entity = NSEntityDescription.entityForName("UserInfo", inManagedObjectContext: managedObjectContext)
        let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        user.setValue(name, forKey: "userName")
        user.setValue(key, forKey: "passWord")
        self.saveContext()
//        do{
//            try managedObjectContext.save()
//        } catch let error as NSError? {
//            NSLog("error saving core data:\(error)")
//            return false
//        }
//        return true
    }
    
    func getData() ->(users: NSArray, nums:Int){
        let fecthRequest = NSFetchRequest(entityName: "UserInfo")
        let entity = NSEntityDescription.entityForName("UserInfo", inManagedObjectContext: managedObjectContext)
        fecthRequest.entity = entity
        var fetchResult = []
        
        do{
            fetchResult = try managedObjectContext.executeFetchRequest(fecthRequest)
        } catch let error as NSError {
            NSLog("error fecth \(error)")
        }
        
        return (fetchResult, fetchResult.count)
    }
    
    func delData(selUser: NSManagedObject) ->Void {
        managedObjectContext.deleteObject(selUser)
        self.saveContext()
    }
    
    
    func modifyData(selUser: NSManagedObject, name: String, key: String) ->Void {
        selUser.setValue(name, forKey: "userName")
        selUser.setValue(key, forKey: "passWord")
        self.saveContext()
    }
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.test._11" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }


}

