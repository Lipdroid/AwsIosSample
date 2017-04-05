//
//  ViewController.swift
//  AwsTestApplication
//
//  Created by Lipu Hossain on 4/5/17.
//  Copyright © 2017 Lipu Hossain. All rights reserved.
//

import UIKit
import AWSDynamoDB

class ViewController: UIViewController {
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scanExpression = AWSDynamoDBScanExpression()
        
        dynamoDBObjectMapper.scan(USERTABLE.self, expression: scanExpression).continueWith(block: { (task:AWSTask<AWSDynamoDBPaginatedOutput>!) -> Any? in
            if let error = task.error as? NSError {
                print("The request failed. Error: \(error)")
            } else if let paginatedOutput = task.result {
                for user in paginatedOutput.items as! [USERTABLE] {
                    // Do something with user.
                    print(user._userEmail ?? "Not found")
                }
            }
            
            return ()
            
        })
        
        dynamoDBObjectMapper.scan(DATATABLE.self, expression: scanExpression).continueWith(block: { (task:AWSTask<AWSDynamoDBPaginatedOutput>!) -> Any? in
            if let error = task.error as? NSError {
                print("The request failed. Error: \(error)")
            } else if let paginatedOutput = task.result {
                for data in paginatedOutput.items as! [DATATABLE] {
                    // Do something with user.
                    print(data._name ?? "Not found")
                }
            }
            
            return ()
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

