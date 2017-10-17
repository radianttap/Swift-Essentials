//
//  FileManager-Extensions.swift
//  Radiant Tap Essentials
//	https://github.com/radianttap/swift-essentials
//
//  Copyright © 2016 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import Foundation


extension FileManager {

	/// Application's home (top-level) directory
	public var homeURL : URL? {
		return URL(fileURLWithPath: NSHomeDirectory())
	}

	///	Put user data in `Documents/`. 
	///	User data generally includes any files you might want to expose to the user—anything you might want the user to create, import, delete or edit.
	public var documentsURL : URL? {
		let paths =	urls(for: .documentDirectory, in: .userDomainMask)
		return paths.first
	}

	/// Put app-created support files in the `Library/Application support/` directory. 
	///	In general, this directory includes files that the app uses to run but that should remain hidden from the user. 
	///	This directory can also include data files, configuration files, templates and modified versions of resources loaded from the app bundle.
	public var applicationSupportURL : URL? {
		let paths =	urls(for: .applicationSupportDirectory, in: .userDomainMask)
		return paths.first
	}

	///	Put temporary data in the `tmp/` directory. 
	///	Temporary data comprises any data that you do not need to persist for an extended period of time. 
	///	Remember to delete those files when you are done with them so that they do not continue to consume space on the user’s device. 
	///	The system will periodically purge these files when your app is not running; therefore, you cannot rely on these files persisting after your app terminates.
	public var temporaryURL : URL? {
		return homeURL?.appendingPathComponent("tmp", isDirectory: true)
//		let path = try? url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: homeURL, create: true)
//		return path
	}

	///	Put data cache files in the `Library/Caches/` directory. 
	///	Cache data can be used for any data that needs to persist longer than temporary data, but not as long as a support file.
	///
	///	Generally speaking, the application does not require cache data to operate properly, but it can use cache data to improve performance. 
	///	Examples of cache data include (but are not limited to) database cache files and transient, downloadable content. 
	///	Note that the system may delete the `Caches/` directory to free up disk space, so your app must be able to re-create or download these files as needed.
	public var cacheURL : URL? {
		let paths =	urls(for: .cachesDirectory, in: .userDomainMask)
		return paths.first
	}


	public func printCommonURLs() {
		if let url = homeURL {
			print("Home:\n\(url)\n")
		}
		if let url = documentsURL {
			print("Documents:\n\(url)\n")
		}
		if let url = applicationSupportURL {
			print("ApplicationSupport:\n\(url)\n")
		}
		if let url = temporaryURL {
			print("Tmp:\n\(url)\n")
		}
		if let url = cacheURL {
			print("Caches:\n\(url)\n")
		}
	}

	public func lookupOrCreate(directoryAt url: URL) -> Bool {

		//	must use ObjCBool as the method method expects that. (yikes)
		var isDirectory : ObjCBool = false

		//	check if something exists with the supplied path
		if fileExists(atPath: url.path, isDirectory: &isDirectory) {
			//	if this is directory
			if isDirectory.boolValue {
				//	then all is fine
				return true
			}
			//	otherwise it's a file, so report back that it's NOT ok
			return false
		}

		//	ok, nothing exists at this path, so create this folder
		do {
			//	also create all required folders in between
			try createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
		} catch let error {
			print(error)
			return false
		}

		return true
	}
}
