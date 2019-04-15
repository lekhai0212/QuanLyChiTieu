//
//  AppDelegate.swift
//  QuanLyChiTieu
//
//  Created by lam quang quan on 4/8/19.
//  Copyright © 2019 KhaiLe. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var expenseMenus:Array<Any>!
    var incomeMenus:Array<Any>!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //  hide title of back bar title
        let attributes = [NSAttributedStringKey.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedStringKey.foregroundColor: UIColor.clear]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
        
        //  check login state
        let username = UserDefaults.standard.value(forKey: key_username)
        let password = UserDefaults.standard.value(forKey: key_password)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.createMenuForAddNote()
        
        
        if username != nil || password != nil {
            let username:String = UserDefaults.standard.value(forKey: key_username) as! String
            let password:String = UserDefaults.standard.value(forKey: key_password) as! String
            
            if username.count > 0 && password.count > 0 {
                
                let homeVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                self.window?.rootViewController = homeVC
            }else{
                let signInVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                
                let navController = UINavigationController()
                navController.viewControllers = [signInVC]
                self.window?.rootViewController = navController
            }
        }else{
            let signInVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            
            let navController = UINavigationController()
            navController.viewControllers = [signInVC]
            self.window?.rootViewController = navController
        }
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "QuanLyChiTieu")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createMenuForAddNote() {
        
        //  Food and Dining
        let foodAndDining = ActionMenuObj.initWithInfo(id:1, name: NSLocalizedString("Food and Dining", comment: ""), code: "food_and_dining", superId: 0)
        
        let barAndCoffee = ActionMenuObj.initWithInfo(id: 2, name: NSLocalizedString("Bars & Coffee", comment: ""), code: "bars_and_coffee", superId: 1)
        let restaurant = ActionMenuObj.initWithInfo(id: 3, name: NSLocalizedString("Restaurant", comment: ""), code: "restaurant", superId: 1)
        let groceries = ActionMenuObj.initWithInfo(id: 4, name: NSLocalizedString("Groceries", comment: ""), code: "groceries", superId: 1)
        
        //  Utilities
        let utilities = ActionMenuObj.initWithInfo(id: 5, name: NSLocalizedString("Utilities", comment: ""), code: "utilities", superId: 0)
        
        let electricity = ActionMenuObj.initWithInfo(id: 6, name: NSLocalizedString("Electricity", comment: ""), code: "electricity", superId: 5)
        let water = ActionMenuObj.initWithInfo(id: 7, name: NSLocalizedString("Water", comment: ""), code: "water", superId: 5)
        let mobilePhone = ActionMenuObj.initWithInfo(id: 8, name: NSLocalizedString("Mobile Phone", comment: ""), code: "mobile_phone", superId: 5)
        let internet = ActionMenuObj.initWithInfo(id: 9, name: NSLocalizedString("Internet", comment: ""), code: "internet", superId: 5)
        let gas = ActionMenuObj.initWithInfo(id: 10, name: NSLocalizedString("Gas", comment: ""), code: "gas", superId: 5)
        let homePhone = ActionMenuObj.initWithInfo(id: 11, name: NSLocalizedString("Home Phone", comment: ""), code: "home_phone", superId: 5)
        let CableTV = ActionMenuObj.initWithInfo(id: 12, name: NSLocalizedString("CableTV", comment: ""), code: "cable_tv", superId: 5)
        let hiringMaids = ActionMenuObj.initWithInfo(id: 13, name: NSLocalizedString("Hiring Maids", comment: ""), code: "hiring_maids", superId: 5)
        
        //  Auto and transport
        let autoAndTransport = ActionMenuObj.initWithInfo(id: 14, name: NSLocalizedString("Auto & Transport", comment: ""), code: "auto_and_transport", superId: 0)
        
        let fuel = ActionMenuObj.initWithInfo(id: 15, name: NSLocalizedString("Fuel", comment: ""), code: "fuel", superId: 14)
        let carWash = ActionMenuObj.initWithInfo(id: 16, name: NSLocalizedString("Car Wash", comment: ""), code: "car_wash", superId: 14)
        let parking = ActionMenuObj.initWithInfo(id: 17, name: NSLocalizedString("Parking", comment: ""), code: "parking", superId: 14)
        let repairVehicles = ActionMenuObj.initWithInfo(id: 18, name: NSLocalizedString("Repair Vehicles", comment: ""), code: "repair_vehicles", superId: 14)
        let serviceAndParts = ActionMenuObj.initWithInfo(id: 19, name: NSLocalizedString("Service & Parts", comment: ""), code: "service_and_parts", superId: 14)
        let taxi = ActionMenuObj.initWithInfo(id: 20, name: NSLocalizedString("Taxi", comment: ""), code: "taxi", superId: 14)
        
        //  Clothing
        let clothing = ActionMenuObj.initWithInfo(id: 21, name: NSLocalizedString("Clothing", comment: ""), code: "clothing", superId: 0)
        
        let clothes = ActionMenuObj.initWithInfo(id: 22, name: NSLocalizedString("Clothes", comment: ""), code: "clothes", superId: 21)
        let accessories = ActionMenuObj.initWithInfo(id: 23, name: NSLocalizedString("Accessories", comment: ""), code: "accessories", superId: 21)
        let shoes = ActionMenuObj.initWithInfo(id: 24, name: NSLocalizedString("Shoes", comment: ""), code: "shoes", superId: 21)
        
        //  Entertainment
        let entertainment = ActionMenuObj.initWithInfo(id: 25, name: NSLocalizedString("Entertainment", comment: ""), code: "entertainment", superId: 0)
        
        let music = ActionMenuObj.initWithInfo(id: 26, name: NSLocalizedString("Music", comment: ""), code: "music", superId: 25)
        let cosmetic = ActionMenuObj.initWithInfo(id: 27, name: NSLocalizedString("Cosmetic", comment: ""), code: "cosmetic", superId: 25)
        let makeup = ActionMenuObj.initWithInfo(id: 28, name: NSLocalizedString("Make up", comment: ""), code: "makeup", superId: 25)
        let moviesAndDVDs = ActionMenuObj.initWithInfo(id: 29, name: NSLocalizedString("Movies & DVDs", comment: ""), code: "movies_and_dvds", superId: 25)
        let travel = ActionMenuObj.initWithInfo(id: 30, name: NSLocalizedString("Travel", comment: ""), code: "travel", superId: 25)
        
        //  Gift and Donations
        let giftAndDonations = ActionMenuObj.initWithInfo(id: 31, name: NSLocalizedString("Gift & Donations", comment: ""), code: "gifts_and_donations", superId: 0)
        
        let charity = ActionMenuObj.initWithInfo(id: 32, name: NSLocalizedString("Charity", comment: ""), code: "charity", superId: 31)
        let funerals = ActionMenuObj.initWithInfo(id: 33, name: NSLocalizedString("Funerals", comment: ""), code: "funerals", superId: 31)
        let gifts = ActionMenuObj.initWithInfo(id: 34, name: NSLocalizedString("Gifts", comment: ""), code: "gifts", superId: 31)
        let marriages = ActionMenuObj.initWithInfo(id: 32, name: NSLocalizedString("Marriages", comment: ""), code: "marriages", superId: 31)
        
        //  Health & Fitness
        let healthAndFitness = ActionMenuObj.initWithInfo(id: 33, name: NSLocalizedString("Health & Fitness", comment: ""), code: "health_and_fitness", superId: 0)
        
        let doctor = ActionMenuObj.initWithInfo(id: 34, name: NSLocalizedString("Doctor", comment: ""), code: "doctor", superId: 33)
        let pharmacy = ActionMenuObj.initWithInfo(id: 35, name: NSLocalizedString("Pharmacy", comment: ""), code: "pharmacy", superId: 33)
        let sports = ActionMenuObj.initWithInfo(id: 36, name: NSLocalizedString("Sports", comment: ""), code: "sports", superId: 33)
        
        //  Home
        let home = ActionMenuObj.initWithInfo(id: 37, name: NSLocalizedString("Home", comment: ""), code: "home", superId: 0)
        
        let furnishing = ActionMenuObj.initWithInfo(id: 38, name: NSLocalizedString("Furnishing", comment: ""), code: "furnishing", superId: 37)
        let homeServices = ActionMenuObj.initWithInfo(id: 39, name: NSLocalizedString("Home Services", comment: ""), code: "home_services", superId: 37)
        let repairOfBuildings = ActionMenuObj.initWithInfo(id: 40, name: NSLocalizedString("Repair of buildings", comment: ""), code: "repair_of_buildings", superId: 37)
        
        //  Kids
        let kids = ActionMenuObj.initWithInfo(id: 41, name: NSLocalizedString("Kids", comment: ""), code: "kids", superId: 0)
        
        let books = ActionMenuObj.initWithInfo(id: 42, name: NSLocalizedString("Books", comment: ""), code: "books", superId: 41)
        let babySupplies = ActionMenuObj.initWithInfo(id: 43, name: NSLocalizedString("Baby Supplies", comment: ""), code: "baby_supplies", superId: 41)
        let allowance = ActionMenuObj.initWithInfo(id: 44, name: NSLocalizedString("Allowance", comment: ""), code: "allowance", superId: 41)
        let toys = ActionMenuObj.initWithInfo(id: 45, name: NSLocalizedString("Toys", comment: ""), code: "toys", superId: 41)
        let tuition = ActionMenuObj.initWithInfo(id: 46, name: NSLocalizedString("Tuition", comment: ""), code: "tuition", superId: 41)
        
        //  personal
        let personal = ActionMenuObj.initWithInfo(id: 47, name: NSLocalizedString("Personal", comment: ""), code: "personal", superId: 0)
        
        let education = ActionMenuObj.initWithInfo(id: 48, name: NSLocalizedString("Education", comment: ""), code: "education", superId: 47)
        let hobbies = ActionMenuObj.initWithInfo(id: 40, name: NSLocalizedString("Hobbies", comment: ""), code: "hobbies", superId: 47)
        
        expenseMenus = [foodAndDining, barAndCoffee, restaurant, groceries, utilities, electricity, water, mobilePhone, internet, gas, homePhone, CableTV, hiringMaids, autoAndTransport, fuel, carWash, parking, repairVehicles, serviceAndParts, taxi, clothing, clothes, accessories, shoes, entertainment, music, cosmetic, makeup, moviesAndDVDs, travel, giftAndDonations, charity, funerals, gifts, marriages, healthAndFitness, doctor, pharmacy, sports, home, furnishing, homeServices, repairOfBuildings, kids, books, babySupplies, allowance, toys, tuition, personal, education, hobbies]
    }

}

