//
//  GTMTestService.swift
//  PageSpeed
//
//  Created by Admin on 09.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

class GTMTestStatusService: Service {
    internal var identifier: String = ""
    let testID: String!
    init (testID: String) {
        self.testID = testID
        generate()
    }
    func run (completion: @escaping (_ response: GTMTestStatusResponse?, _ error: Error?) -> Void) {
        started()
        let provider = MoyaProvider<GTMatrixAPI>()
        provider.request(.testStatus(testID: self.testID)) { response in
            switch response {
            case .success(let result):
                print(String(data: result.data, encoding: .utf8))
                let decoder = JSONDecoder()
                do {
                    let testResponse = try decoder.decode(GTMTestStatusResponse.self, from: result.data)
                    completion(testResponse, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
            self.finished()
        }
    }
}