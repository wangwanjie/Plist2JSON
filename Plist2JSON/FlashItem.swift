
//
//  FlashItem.swift
//  Plist2JSON
//
//  Created by ringBet on 2017/11/10.
//  Copyright © 2017年 3ring. All rights reserved.
//

import Foundation
import HandyJSON

struct FlashItem: HandyJSON {
	var Group: String?
	var English: String?
	var Code: String?
	var Accessible: String?
	var type: String?
	var Chinese: String?
	var tw: String?
	var Supported: String?
	
	mutating func mapping(mapper: HelpingMapper) {
		mapper <<<
			self.type <-- "Type"
	}
}
