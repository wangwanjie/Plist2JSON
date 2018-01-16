//
//  ViewController.swift
//  Plist2JSON
//
//  Created by ringBet on 2017/11/9.
//  Copyright © 2017年 3ring. All rights reserved.
//

import UIKit
import HandyJSON

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		if let path = Bundle.main.path(forResource: "new_HTML5", ofType: "plist"), let dictArr = NSArray(contentsOfFile: path) as? [NSDictionary] {
			var data = [HTML5Item]()
			for dictOut in dictArr {
				let entity = JSONDeserializer<HTML5Item>.deserializeFrom(dict: dictOut)
				data.append(entity!)
			}
			//			print(data)
			
			var dd = [[String: String?]]()
			data.filter({ (item) -> Bool in
				return item.Accessible == "Y" && item.Supported == "Y"
			}).forEach({ (item) in
				let neededItem = ["zh_CN": item.Chinese, "zh_HK": item.tw, "en_US": item.English, "eventFn": item.Code, "category": item.type, "imgSrc": "newPT/\(item.Code!).png", "Flash": "0", "H5": "1", "Jackpot": "0", "status": "1"]
				dd.append(neededItem)
			})
			let dic: [String: Any] = ["hot": dd, "slot": dd]
			
			do {
				let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
				
				let writableFileURL = documentDirectoryURL.appendingPathComponent("newWap.json", isDirectory: false)
				
				let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
				
				try jsonData.write(to: writableFileURL)
				
				// here "jsonData" is the dictionary encoded in JSON data
				
				let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
				// here "decoded" is of type `Any`, decoded from JSON data
				
				// you can now cast it with the right type
				if let dictFromJSON = decoded as? [String:String] {
					// use dictFromJSON
					
				}
			} catch {
				print(error.localizedDescription)
			}
			
		}
//
//		if let path = Bundle.main.path(forResource: "new_FLASH", ofType: "plist"), let dictArr = NSArray(contentsOfFile: path) as? [NSDictionary] {
//			var data = [FlashItem]()
//			for dictOut in dictArr {
//				let entity = JSONDeserializer<FlashItem>.deserializeFrom(dict: dictOut)
//				data.append(entity!)
//			}
//			//			print(data)
//
//			var dd = [[String: String?]]()
//			data.filter({ (item) -> Bool in
//				return item.Accessible == "Y" && item.Supported == "Y"
//			}).forEach({ (item) in
//				let neededItem = ["gameName": item.Chinese, "twName": item.tw, "enName": item.English, "gameCode": item.Code, "gameType": item.type, "gameImgName": "newPT/\(item.Code!).png", "gameShi": "1"]
//				dd.append(neededItem)
//			})
//			let dic: [String: Any] = ["code": 0, "gameData": dd]
//
//			do {
//				let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
//
//				let writableFileURL = documentDirectoryURL.appendingPathComponent("newWeb.json", isDirectory: false)
//
//				let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
//
//				try jsonData.write(to: writableFileURL)
//
//				// here "jsonData" is the dictionary encoded in JSON data
//
//				let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
//				// here "decoded" is of type `Any`, decoded from JSON data
//
//				// you can now cast it with the right type
//				if let dictFromJSON = decoded as? [String:String] {
//					// use dictFromJSON
//					//					jsonData.wr
//				}
//			} catch {
//				print(error.localizedDescription)
//			}
//
//		}
		
//		generateWapPTGameJOSN()
		
//		generateWebPTGameJOSN()
	}
	
	func generateWapPTGameJOSN() {
		if let html5 = wapHtml5(), let flash = wapFlash() {
			var inFlash = flash
			
			// 游戏去重
			var merged = html5 + inFlash
			merged = noDuplicatesWap(merged)
			
			let dic: [String: Any] = ["hot": merged, "slot": merged]
			
			do {
				let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
				
				let writableFileURL = documentDirectoryURL.appendingPathComponent("Wap.json", isDirectory: false)
				
				let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
				
				try jsonData.write(to: writableFileURL)
				
				// here "jsonData" is the dictionary encoded in JSON data
				
				let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
				// here "decoded" is of type `Any`, decoded from JSON data
				
				// you can now cast it with the right type
				if let dictFromJSON = decoded as? [String:String] {
					// use dictFromJSON
					//					jsonData.wr
				}
			} catch {
				print(error.localizedDescription)
			}
		} else {
			print("html5 or flash is nil")
		}
	}
	
	func generateWebPTGameJOSN() {
		if let html5 = webHtml5(), let flash = webFlash() {
			var inFlash = flash
			
			// 游戏去重
			var merged = html5 + inFlash
			merged = noDuplicates(merged)
			
			let dic: [String: Any] = ["code": 0, "gameData": merged]
			
			do {
				let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
				
				let writableFileURL = documentDirectoryURL.appendingPathComponent("Web.json", isDirectory: false)
				
				let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
				
				try jsonData.write(to: writableFileURL)
				
				// here "jsonData" is the dictionary encoded in JSON data
				
				let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
				// here "decoded" is of type `Any`, decoded from JSON data
				
				// you can now cast it with the right type
				if let dictFromJSON = decoded as? [String:String] {
					// use dictFromJSON
					//					jsonData.wr
				}
			} catch {
				print(error.localizedDescription)
			}
		} else {
			print("html5 or flash is nil")
		}
	}
	func webHtml5() -> [[String: String?]]? {
		if let path = Bundle.main.path(forResource: "HTML5", ofType: "plist"), let dictArr = NSArray(contentsOfFile: path) as? [NSDictionary] {
			var data = [HTML5Item]()
			for dictOut in dictArr {
				let entity = JSONDeserializer<HTML5Item>.deserializeFrom(dict: dictOut)
				data.append(entity!)
			}
			//			print(data)
			
			var dd = [[String: String?]]()
			data.forEach({ (item) in
				let neededItem = ["gameName": item.Chinese, "twName": item.tw, "enName": item.English, "gameCode": item.Code, "gameType": item.type, "gameImgName": "newPT/\(item.Code!).png", "gameShi": "1"]
				dd.append(neededItem)
			})
			return dd
		} else {
			return nil
		}
	}
	
	func wapHtml5() -> [[String: String?]]? {
		if let path = Bundle.main.path(forResource: "HTML5", ofType: "plist"), let dictArr = NSArray(contentsOfFile: path) as? [NSDictionary] {
			var data = [HTML5Item]()
			for dictOut in dictArr {
				let entity = JSONDeserializer<HTML5Item>.deserializeFrom(dict: dictOut)
				data.append(entity!)
			}
			//			print(data)
			
			var dd = [[String: String?]]()
			data.forEach({ (item) in
				let neededItem = ["zh_CN": item.Chinese, "zh_HK": item.tw, "en_US": item.English, "eventFn": item.Code, "category": item.type, "imgSrc": "newPT/\(item.Code!).png", "Flash": "0", "H5": "1", "Jackpot": "0", "status": "1"]
				dd.append(neededItem)
			})
			return dd
		} else {
			return nil
		}
	}
	
	func webFlash() -> [[String: String?]]? {
		if let path = Bundle.main.path(forResource: "FLASH", ofType: "plist"), let dictArr = NSArray(contentsOfFile: path) as? [NSDictionary] {
			var data = [FlashItem]()
			for dictOut in dictArr {
				let entity = JSONDeserializer<FlashItem>.deserializeFrom(dict: dictOut)
				data.append(entity!)
			}
			//			print(data)
			
			var dd = [[String: String?]]()
			data.forEach({ (item) in
				let neededItem = ["gameName": item.Chinese, "twName": item.tw, "enName": item.English, "gameCode": item.Code, "gameType": item.type, "gameImgName": "newPT/\(item.Code!).png", "gameShi": "1"]
				dd.append(neededItem)
			})
			return dd
		} else {
			return nil
		}
	}
	func wapFlash() -> [[String: String?]]? {
		if let path = Bundle.main.path(forResource: "FLASH", ofType: "plist"), let dictArr = NSArray(contentsOfFile: path) as? [NSDictionary] {
			var data = [FlashItem]()
			for dictOut in dictArr {
				let entity = JSONDeserializer<FlashItem>.deserializeFrom(dict: dictOut)
				data.append(entity!)
			}
			//			print(data)
			
			var dd = [[String: String?]]()
			data.forEach({ (item) in
				let neededItem = ["zh_CN": item.Chinese, "zh_HK": item.tw, "en_US": item.English, "eventFn": item.Code, "category": item.type, "imgSrc": "newPT/\(item.Code!).png", "Flash": "1", "H5": "0", "Jackpot": "0", "status": "1"]
				dd.append(neededItem)
			})
			return dd
		} else {
			return nil
		}
	}
	func noDuplicates(_ arrayOfDicts: [[String: String?]]) -> [[String: String?]] {
		var noDuplicates = [[String: String?]]()
		var usedNames = [String]()
		for dict in arrayOfDicts {
			if let name = dict["gameCode"], !usedNames.contains(name!) {
				noDuplicates.append(dict)
				usedNames.append(name!)
			}
		}
		return noDuplicates
	}
	
	func noDuplicatesWap(_ arrayOfDicts: [[String: String?]]) -> [[String: String?]] {
		var noDuplicates = [[String: String?]]()
		var usedNames = [String]()
		for dict in arrayOfDicts {
			if let name = dict["eventFn"], !usedNames.contains(name!) {
				noDuplicates.append(dict)
				usedNames.append(name!)
			}
		}
		return noDuplicates
	}
}
