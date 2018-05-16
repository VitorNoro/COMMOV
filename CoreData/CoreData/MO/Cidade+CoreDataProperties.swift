//
//  Cidade+CoreDataProperties.swift
//  CoreData
//
//  Created by DocAdmin on 5/16/18.
//  Copyright © 2018 ei. All rights reserved.
//
//

import Foundation
import CoreData


extension Cidade {


    @NSManaged public var nome: String?
    @NSManaged public var tem_pais: Pais?

}
