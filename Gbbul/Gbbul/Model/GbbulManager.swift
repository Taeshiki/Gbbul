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
    
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("저장 중 오류 발생: \(error)")
            }
        }
    }
    
    
    func createUser(name : String) {
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
    
    
    func createMyBook(name: String, id: Int){
        guard let myBookEntity = NSEntityDescription.entity(forEntityName: "MyBook", in: mainContext) else {
            fatalError("MyBook Entity를 찾을 수 없습니다.")
        }
        let myBook = NSManagedObject(entity: myBookEntity, insertInto: mainContext)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        myBook.setValue(id, forKey: "bookId")
        myBook.setValue(name, forKey: "myBookName")
        myBook.setValue(dateString, forKey: "myCreateDate")
        
        saveContext()
    }
    
    
    func getMyBook() -> [MyBook]? {
        var bookList: [MyBook] = []
        
        do {
            let fetchBookList = try mainContext.fetch(MyBook.fetchRequest())
            bookList = fetchBookList
        } catch {
            print("데이터를 가져오는 중 오류 발생: \(error)")
            return nil
        }
        return bookList
    }
    
    
    func updateMyBookName(newBookName: String, selectedBookId: Int64) {
        let request = NSFetchRequest<MyBook>(entityName: "MyBook")
        request.predicate = NSPredicate(format: "bookId == %ld", selectedBookId)
        
        do {
            let fetchedBooks = try mainContext.fetch(request)
            if let targetBook = fetchedBooks.first {
                targetBook.myBookName = newBookName
                saveContext()
            }
        } catch {
            print("업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    
    func deleteMyBook(_ book: MyBook) {
        mainContext.delete(book)
        saveContext()
    }
    
    
    func deleteWordsInBook(_ book: MyBook) {
        let bookId = book.bookId
        
        let fetchRequest: NSFetchRequest<MyVoca> = MyVoca.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookId == %lld", bookId)
        
        do {
            let wordsToDelete = try mainContext.fetch(fetchRequest)
            for word in wordsToDelete {
                mainContext.delete(word)
            }
            saveContext()
        } catch {
            print("단어 삭제 중 오류 발생: \(error)")
        }
    }

    
    func createMyVoca(bookId: Int64, vocaName: String, vocaMean: String) {
        guard let myVocaEntity = NSEntityDescription.entity(forEntityName: "MyVoca", in: mainContext) else {
            fatalError("MyVoca Entity를 찾을 수 없습니다.")
        }
        
        let myVoca = NSManagedObject(entity: myVocaEntity, insertInto: mainContext)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        myVoca.setValue(bookId, forKey: "bookId")
        myVoca.setValue(dateString, forKey: "myCreateDate")
        myVoca.setValue(UUID().hashValue, forKey: "myVocaId")
        myVoca.setValue(vocaName, forKey: "myVocaName")
        myVoca.setValue(vocaMean, forKey: "myVocaMean")
        
        saveContext()
    }
    
    
    func deleteMyVoca(myVoca: MyVoca) {
        mainContext.delete(myVoca)
        saveContext()
    }

    
    func getMyVoca(by bookId: Int64) -> [MyVoca]? {
        let fetchRequest: NSFetchRequest<MyVoca> = MyVoca.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookId == %@", NSNumber(value: bookId))
        
        do {
            let vocas = try mainContext.fetch(fetchRequest)
            return vocas
        } catch {
            print("데이터를 가져오는 중 오류 발생: \(error)")
            return nil
        }
    }
    
    
    func getVoca(by bookId: Int64) -> [Voca]? {
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "bookId == %@", NSNumber(value: bookId))
        
        do {
            let vocas = try mainContext.fetch(fetchRequest)
            return vocas
        } catch {
            print("데이터를 가져오는 중 오류 발생: \(error)")
            return nil
        }
    }
    
    func createCorrectRate(by bookId: Int64, correct: Int, incorrect: Int, rate: Double, total: Int) {
        guard let correctRateEntity = NSEntityDescription.entity(forEntityName: "CorrectRate", in: mainContext) else {
            fatalError("CorrectRate Entity를 찾을 수 없습니다.")
        }
        
        let correctRate = NSManagedObject(entity: correctRateEntity, insertInto: mainContext)
        
        correctRate.setValue(bookId, forKey: "bookId")
        correctRate.setValue(correct, forKey: "correct")
        correctRate.setValue(incorrect, forKey: "incorrect")
        correctRate.setValue(rate, forKey: "rate")
        correctRate.setValue(total, forKey: "total")
        
        saveContext()
    }
    
    func getCorrectRate() -> [CorrectRate]? {
        let fetchRequest: NSFetchRequest<CorrectRate> = CorrectRate.fetchRequest()
        
        do {
            let rate = try mainContext.fetch(fetchRequest)
            return rate
        } catch {
            print("데이터를 가져오는 중 오류 발생: \(error)")
            return nil
        }
    }
}
