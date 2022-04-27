//
//  CommitsHistoryManager.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import Foundation
import Combine

class CommitsHistoryManager {
    
    @Published private var commitHisrotyModel: [CommitsHistory]? = []
    
    private let searchModel: SearchModel?
    
    init(searchModel: SearchModel?) {
        self.searchModel = searchModel
    }
    
    var commitHistoryModelPublisher: AnyPublisher <[CommitsHistory]?, Never> {
        return $commitHisrotyModel.map{ $0 }
        .eraseToAnyPublisher()
    }
    
    func loadCommitHistory() {
        guard let searchModel = searchModel else { return }
        
        let endpoint = CommitHistoryEndpoint(repoTitle: searchModel.repoTitle, authorName: searchModel.authorName)
        let networkManager = NetworkManager<[RawCommitsHistoryElement]>()
        
        networkManager.getInfo(for: endpoint) { result in
            self.commitHisrotyModel = self.processRawResult(result)
        }
    }
    
    //Proccesses and populate model
    private func processRawResult(_ rawData: [RawCommitsHistoryElement]?) -> [CommitsHistory] {
        var entries = [CommitsHistory]()
        guard let rawData = rawData else { return [] }
        
        for index in 0..<3 {
            if rawData.count - 1 >= index {
                let author = rawData[index].committer?.login
                let email = rawData[index].commit?.author?.email
                let description = rawData[index].commit?.message
                
                let entry = CommitsHistory(author: author, email: email, description: description)
                entries.append(entry)
            }
        }
        return entries
    }
    
    
}
