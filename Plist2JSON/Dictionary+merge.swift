
//
//  Dictionary+merge.swift
//  Plist2JSON
//
//  Created by ringBet on 2017/11/10.
//  Copyright © 2017年 3ring. All rights reserved.
//

import Foundation

extension Dictionary {
	mutating func merge<S>(_ other: S) where S: Sequence, S.Iterator.Element == (key: Key, vlaue: Value) {
		for (k, v) in other {
			self[k] = v
		}
	}
}
