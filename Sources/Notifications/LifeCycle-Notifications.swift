//
//  LifeCycle-Notifications.swift
//  Radiant Tap Essentials
//
//  Copyright © 2020 Radiant Tap
//  MIT License · http://choosealicense.com/licenses/mit/
//

import UIKit

@available(iOS 13.0, *)
struct SceneLifeCycleNotification {
	init?(notification: Notification) {
	}
}

@available(iOS 13.0, *)
extension SceneLifeCycleNotification {
	static let willConnect = NotificationDescriptor<SceneLifeCycleNotification>(name: UIScene.willConnectNotification, convert: SceneLifeCycleNotification.init)
	static let didDisconnect = NotificationDescriptor<SceneLifeCycleNotification>(name: UIScene.didDisconnectNotification, convert: SceneLifeCycleNotification.init)
	static let didActivate = NotificationDescriptor<SceneLifeCycleNotification>(name: UIScene.didActivateNotification, convert: SceneLifeCycleNotification.init)
	static let willDeactivate = NotificationDescriptor<SceneLifeCycleNotification>(name: UIScene.willDeactivateNotification, convert: SceneLifeCycleNotification.init)
	static let willEnterForeground = NotificationDescriptor<SceneLifeCycleNotification>(name: UIScene.willEnterForegroundNotification, convert: SceneLifeCycleNotification.init)
	static let didEnterBackground = NotificationDescriptor<SceneLifeCycleNotification>(name: UIScene.didEnterBackgroundNotification, convert: SceneLifeCycleNotification.init)
}
