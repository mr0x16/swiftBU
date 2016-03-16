//
//  swiftTestUserInfo+CoreDataProperties.swift
//  swiftTest
//
//  Created by bocom on 16/1/27.
//  Copyright © 2016年 com.bankcomm. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension swiftTestUserInfo {

    @NSManaged var passWord: String?
    @NSManaged var userName: String?

}
