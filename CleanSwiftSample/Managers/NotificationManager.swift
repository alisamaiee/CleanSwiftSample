//
//  NotificationManager.swift
//  CleanSwiftSample
//
//  Created by Ali Samaiee on 8/10/21.
//

import Foundation

/// A custom lightweight event handler
class NotificationManager {
    static let sharedInstance = NotificationManager()
    
    public static let selectedCountriesChanged = 0
    
    private var observers = [Int: [AnyObject]]()
    private var removeAfterBroadcast = [Int: [AnyObject]]()
    private var addAfterBroadcast = [Int: [AnyObject]]()
    private var delayedPosts = Array<DelayedPost?>(repeating: nil, count: 10)
    
    private var broadcasting = 0
    private var animationInProgress: Bool = false
    
    private var allowedNotifications: [Int]?
    
    func setAnimationInProgress(value: Bool) {
        self.animationInProgress = value
        if (!animationInProgress && !self.delayedPosts.isEmpty) {
            for delayedPost in self.delayedPosts {
                if let strongPost = delayedPost {
                    do {
                        try self.postNotificationNameInternal(strongPost.id, true, strongPost.args)
                    } catch {
                        Logger.printToConsole(error.localizedDescription)
                    }
                }
            }
            delayedPosts.removeAll()
        }
    }
    
    func postNotificationName(_ id: Int, _ args: [Any], forceDuringAnimations: Bool = false) {
        var allowDuringAnimation = forceDuringAnimations
        if self.allowedNotifications != nil && !forceDuringAnimations {
            for allowedNotification in self.allowedNotifications! {
                if allowedNotification == id {
                    allowDuringAnimation = true
                    break
                }
            }
        }
        try? self.postNotificationNameInternal(id, allowDuringAnimation, args)
    }
    
    func postNotificationNameInternal(_ id: Int, _ allowDuringAnimation: Bool, _ args: [Any]) throws {
        if !Thread.isMainThread {
            throw RuntimeError("NotificationManager::postNotificationNameInternal -> allowed only from MAIN thread")
        }
        
        if !allowDuringAnimation && animationInProgress {
            let delayedPost = DelayedPost(id,args)
            self.delayedPosts.append(delayedPost)
            
            return
        }
        
        self.broadcasting += 1
        let objects = self.observers[id]
        
        if objects != nil && !objects!.isEmpty {
            for obj in objects! {
                if let delegate = obj as? NotificationCenterDelegate {
                    delegate.didReceivedNotification(id, args: args)
                }
            }
        }
        self.broadcasting -= 1
        if self.broadcasting == 0 {
            if !removeAfterBroadcast.isEmpty {
                for object in removeAfterBroadcast {
                    let arrayList = object.value
                    
                    for obj in arrayList {
                        try self.removeObserver(obj, object.key)
                    }
                }
                removeAfterBroadcast.removeAll()
            }
            if !addAfterBroadcast.isEmpty {
                for object in addAfterBroadcast {
                    let key = object.key
                    let value = object.value
                    
                    for obj in value {
                        try self.addObserver(obj, key)
                    }
                }
                addAfterBroadcast.removeAll()
            }
        }
    }
    
    /// Don't forget to call removeObserver when your observing task is over
    func addObserver(_ observer: AnyObject, _ id: Int) throws {
        if !Thread.isMainThread {
            throw RuntimeError("NotificationManager::postNotificationNameInternal -> allowed only from MAIN thread")
        }
        
        var objects = self.observers[id]
        if objects == nil {
            objects = [AnyObject]()
        }
        
        if objects!.contains(where: { anyObjectListItem -> Bool in return observer === anyObjectListItem }) {
            return
        }
        
        objects!.append(observer)
        
        self.observers[id] = objects!
    }
    
    func removeObserver(_ observer: AnyObject, _ id: Int) throws {
        if !Thread.isMainThread {
            throw RuntimeError("NotificationManager::postNotificationNameInternal -> allowed only from MAIN thread")
        }
        
        if broadcasting != 0 {
            var arrayList = removeAfterBroadcast[id]
            if arrayList == nil {
                arrayList = [AnyObject]()
                removeAfterBroadcast[id] = arrayList
            }
            arrayList?.append(observer)
            return
        }
        var objects = observers[id]
        if objects != nil {
            let index = objects?.firstIndex(where: { anyObjectListItem -> Bool in
                return anyObjectListItem === observer
            })
            
            if index != nil {
                objects?.remove(at: index!)
                self.observers[id] = objects!
            }
        }
    }
    
    func cleanup() {
        self.observers.removeAll()
        self.removeAfterBroadcast.removeAll()
        self.addAfterBroadcast.removeAll()
        self.delayedPosts.removeAll()
        self.allowedNotifications?.removeAll()
    }
}

protocol NotificationCenterDelegate: class {
    func didReceivedNotification(_ id: Int, args: [Any])
}

class DelayedPost {
    fileprivate let id: Int!
    fileprivate let args: [Any]
    
    fileprivate init(_ id: Int, _ args: [Any]) {
        self.id = id
        self.args = args
    }
}
