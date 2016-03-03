//
//  Staff.swift
//  ZooKeeper
//
//  Created by Clayton Harper on 2/11/16.
//  Copyright © 2016 Clayton Harper. All rights reserved.
//

import UIKit

public class Staff {
    var type: String
    var name: String
    var isMale: Bool
    var currentWeight: Float?
    var birthday: NSDate?
    var photoFileName: String?
    
    public init(type: String, name: String, isMale: Bool) {
        self.type = type
        self.name = name
        self.isMale = isMale
    }
    
    deinit {
        print("Oh No!")
    }
    /**
     - Returns: A string descibing the staff member
     */
    public func report() -> String {
        return "I'm a \(isMale ? "male" : "female") and my name is \(name) "
    }
    
    public func image() -> UIImage? {
        return UIImage(named: type.lowercaseString)
    }
	
	public func hasImage() -> Bool {
		return photoFileName != nil
	}
	
	public func saveImage(image: UIImage) -> Bool {
		if let data = UIImageJPEGRepresentation(image, 0.8) {
			photoFileName = NSUUID().UUIDString + ".jpg"
			let path = CTHPathToFileInDocumentsDirectory(photoFileName!)
			print("writing to \(path)")
			return data.writeToFile(path, atomically: true)
		}
		return false
	}
	
	public func loadImage() -> UIImage? {
		guard let filename = photoFileName,
			let path = CTHPathToExistingFileInDocumentsDirectory(filename),
			let image = UIImage(contentsOfFile: path) else { return nil }
		
		return image
	}
	
	private func birthdayString() -> String? {
		guard let day = birthday else {return nil}
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = dateFormatString
		return formatter.stringFromDate(day)
	}
	
	public static func dateFromString(string: String?) -> NSDate? {
		guard let string = string else {return nil}
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = dateFormatString
		return formatter.dateFromString(string)
	}
	
	// Maps Json Objects to Swift Objects
	public func toDictionary() -> [String: AnyObject] {
		return ["type": type,
				"name": name,
				"isMale": isMale,
				"currentWeight": currentWeight ?? -1,
				"birthday" : birthdayString() ?? "",
				"photoFileName": photoFileName ?? ""
		]
	}

}
public class ZooKeeper : Staff {
    public init(name: String, isMale: Bool) {
        super.init(type: "ZooKeeper", name: name, isMale: isMale)
    }
}
public class TicketTaker : Staff {
    public init(name: String, isMale: Bool) {
        super.init(type: "TicketTaker", name: name, isMale: isMale)
    }
}
