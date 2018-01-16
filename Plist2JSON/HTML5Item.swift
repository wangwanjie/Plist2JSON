//
//  HTML5Item.swift
//  Plist2JSON
//
//  Created by ringBet on 2017/11/9.
//  Copyright © 2017年 3ring. All rights reserved.
//

import Foundation
import HandyJSON

struct HTML5Item: HandyJSON {
	var Chinese: String?
	var Code: String?
	var English: String?
	var Group: String?
	var type: String?
	var tw: String?
	var Supported: String?
	var Accessible: String?
	
	mutating func mapping(mapper: HelpingMapper) {
		mapper <<<
			self.type <-- "Type"
	}
}
