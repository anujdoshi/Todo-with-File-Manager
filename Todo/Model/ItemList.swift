//
//  ItemList.swift
//  Todo
//
//  Created by Anuj Doshi on 28/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import Foundation

class ItemList:Encodable,Decodable{
    var item:String = ""
    var done:Bool = false
    var topicName:String = ""
}
