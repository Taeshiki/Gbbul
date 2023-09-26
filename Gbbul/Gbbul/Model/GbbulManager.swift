//
//  GbbulManager.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import CoreData

class GbbulManager {
    init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GbbulCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func createUser(name : String)
    {
        guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: mainContext) else {
            fatalError("User 엔터티를 찾을 수 없습니다.")
        }
        let user = NSManagedObject(entity: userEntity, insertInto: mainContext)
        user.setValue(name, forKey: "name")
        user.setValue(0, forKey: "exp")
        user.setValue(0, forKey: "level")
        saveContext()
    }
    func getUser() -> [User]? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try mainContext.fetch(fetchRequest)
            return users
        } catch {
            print("데이터를 가져오는 중 오류 발생: \(error)")
            return nil
        }
    }
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("저장 중 오류 발생: \(error)")
            }
        }
    }
}
