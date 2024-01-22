//
//  ViewController.swift
//  Thread
//
//  Created by Darya on 10.01.24.
//

import UIKit

// GCD
class BankAccount {
    var balance : Double = 0
    let synchronizationQueue = DispatchQueue(label: "synchronizationQueue", attributes: .concurrent)

    func deposit ( amount : Double ) {
        synchronizationQueue.async(flags: .barrier) {
            self.balance += amount
            print("Пополнение: \(amount), итого : \(self.balance)")
        }
    }
    func withdraw ( amount : Double ) {
        synchronizationQueue.async(flags: .barrier) {
            if self.balance >= amount {
                self.balance -= amount
                print("Снятие: \(amount), итого : \(self.balance)")
        } else {
            print ("Недостаточно средств")
        }
        }
       
    }
}


//- Thread
//class BankAccount {
//    var balance : Double = 0
//    private let lock = NSLock()
//    
//    func deposit ( amount : Double ) {
//        lock.lock()
//        balance += amount
//        print("Пополнение: \(amount), итого : \(balance)")
//        lock.unlock()
//    }
//    func withdraw ( amount : Double ) {
//        lock.lock()
//        if balance >= amount {
//            balance -= amount
//            print("Снятие: \(amount), итого : \(balance)")
//        } else {
//            print ("Недостаточно средств")
//        }
//        lock.unlock()
//    }
//}

class ViewController: UIViewController {

    let bankAccount = BankAccount()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
// GCD
    
        let conccurentQueue = DispatchQueue(label: "BankAccountQueue", attributes: .concurrent)
        conccurentQueue.async {
            self.bankAccount.deposit(amount: 15)
        }
        conccurentQueue.async {
            self.bankAccount.withdraw(amount: 10)
        }
        conccurentQueue.async {
            self.bankAccount.deposit(amount: 20)
        }
    
        
        
//- Thread
//        let firstThread = Thread {
//            self.bankAccount.deposit(amount: 15)
//        }
//        
//        let secondThread = Thread {
//            self.bankAccount.withdraw(amount: 10)
//        }
//        let nextThread = Thread {
//            self.bankAccount.deposit(amount: 20)
//        }
//        firstThread.start()
//        secondThread.start()
//        nextThread.start()
       

        
    }


}

