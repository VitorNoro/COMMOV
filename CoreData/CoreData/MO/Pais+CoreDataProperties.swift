//
//  Pais+CoreDataProperties.swift
//  CoreData
//
//  Created by DocAdmin on 5/16/18.
//  Copyright © 2018 ei. All rights reserved.
//
//

import Foundation
import CoreData


extension Pais {

    @NSManaged public var nome: String?
    @NSManaged public var populacao: Int16
    @NSManaged public var tem_cidade: NSSet?

}
