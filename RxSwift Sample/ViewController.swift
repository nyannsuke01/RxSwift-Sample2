//
//  ViewController.swift
//  RxSwift Sample
//
//  Created by user on 2022/08/28.
//

import UIKit
import RxSwift


class ViewController: UIViewController {
    
    let prices = [100, 250, 560, 980]
    let taxRate = 1.08

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.Settings
        calcTaxRate()
        test()
    }
    
    func calcTaxRate() {
        Observable
            .from(prices)
            .map({ price in
                Int(Double(price) * self.taxRate)
            })
            .subscribe({ event in
                print(event)
            })
            .dispose()
    }
    
    func test() {
        
        let disposeBag = DisposeBag()
        
        // Subject作成
        let subject = PublishSubject<String>()
        
        subject.onNext("🍎")
        
        // Observer1購読
        subject
            .subscribe(onNext: { element in
                print("Observer: 1 - Event: \(element)")
            }, onCompleted: {
                print("Observer: 1 - Event: completed")
            }, onDisposed: {
                print("Observer: 1 - Event: disposed")
            })
            .disposed(by: disposeBag)
        
        subject.onNext("🍣")
        
        // Observer2購読
        subject
            .map({ element in
                "\(element) is nice!"
            })
            .subscribe(onNext: { element in
                print("Observer: 2 - Event: \(element)")
            }, onCompleted: {
                print("Observer: 2 - Event: completed")
            }, onDisposed: {
                print("Observer: 2 - Event: disposed")
            })
            .disposed(by: disposeBag)

        subject.onNext("🍔")
        
        // Observer3購読
        subject
            .subscribe(onNext: { element in
                print("Observer: 3 - Event: \(element)")
            }, onCompleted: {
                print("Observer: 3 - Event: completed")
            }, onDisposed: {
                print("Observer: 3 - Event: disposed")
            })
            .disposed(by: disposeBag)
        
        subject.onNext("🍜")
        
        subject.onCompleted()
    }


}

