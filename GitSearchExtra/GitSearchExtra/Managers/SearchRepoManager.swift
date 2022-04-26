//
//  SearchManager.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/26/22.
//

import Foundation
import Combine
import UIKit


class SearchRepoManager {
    
    @Published private var model: [SearchModel]? = []
    
    private var matching: String?// needs for additional data downloads
    private var pageNumber = 1 // needs for additional data downloads
    
    var modelPublisher: AnyPublisher <[SearchModel]?, Never> {
        return $model.map{ $0 }
        .eraseToAnyPublisher()
    }
    
    //Used for initial data load. Does not load images
    func loadSearchResults(matching: String, pageNumber: Int) {
        let networkManager = NetworkManager<RawSearchModel>()
        
        self.matching = matching
        self.pageNumber = pageNumber
        self.pageNumber += 1
        
        let endpoint = SearchEndpoint.search(matching: matching)
        networkManager.getInfo(for: endpoint) { rawData in
            let entries = self.processRawData(from: rawData)
            self.model = entries
        }
    }
    
    func getMoreEntries() {
        guard let matching = matching else { return }

        let networkManager = NetworkManager<RawSearchModel>()
        let endpoint = SearchEndpoint.search(matching: matching, pageNumber: self.pageNumber)
        
        networkManager.getInfo(for: endpoint) { rawData in
            let entries = self.processRawData(from: rawData)
        
            if self.model != nil {
                self.model! += entries
            }
            self.pageNumber += 1
            
        }
    }
    
    //Loads avatar images. Ideal case: once the container with image is presented, delegate fires the call to download the image.
    func loadAvatar(for index: Int, completion: @escaping() -> Void) {
        let link = getAvatarLink(for: index)
        
        let networkManager = NetworkManager<Data>()
        networkManager.makeImageRequest(from: link) { image in
            self.changeImageInModel(image: image, index: index)
            completion()
        }
    }
    
    //Once image is downloaded, updates entry within the model
    private func changeImageInModel(image: UIImage?, index: Int) {
        guard let model = model else { return }

        if model[index].avatarImage == nil {
            model[index].avatarImage = image
        }
        
    }
    
    //Creates the initial entry for the model.
    private func createEntry(from item: Item?) -> SearchModel {
        let avatarURL = item?.owner?.avatarURL
        let avatarImage: UIImage? = nil
        let repoTitle = item?.name
        let repoStars = item?.stargazersCount
        let authorID = item?.owner?.id
        let authorName = item?.owner?.login
        
        return SearchModel(avatarURL: avatarURL, avatarImage: avatarImage, repoTitle: repoTitle, repoStars: repoStars, authorID: authorID, authorName: authorName)
    }
    
    //Processes the raw chunk of data, creates model entries.
    private func processRawData(from data: RawSearchModel?) -> [SearchModel] {
        var entries = [SearchModel]()
        data?.items?.forEach {
            let entry = self.createEntry(from: $0)
            entries.append(entry)
        }
        return entries
    }
    
    private func getAvatarLink(for index: Int) -> String? {
        guard let model = model, model.count - 1 >= index else {
            return nil
        }
        return model[index].avatarURL
    }
}
