//
//  RawCommitsHistory.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/27/22.
//

import Foundation


// MARK: - CommitsHistoryElement
class RawCommitsHistoryElement: Codable {
    let sha: String?
    let nodeID: String?
    let commit: Commit?
    let url: String?
    let htmlURL: String?
    let commentsURL: String?
    let author: CommitsHistoryAuthor?
    let committer: CommitsHistoryAuthor?
    let parents: [Parent]?

    enum CodingKeys: String, CodingKey {
        case sha = "sha"
        case nodeID = "node_id"
        case commit = "commit"
        case url = "url"
        case htmlURL = "html_url"
        case commentsURL = "comments_url"
        case author = "author"
        case committer = "committer"
        case parents = "parents"
    }

    init(sha: String?, nodeID: String?, commit: Commit?, url: String?, htmlURL: String?, commentsURL: String?, author: CommitsHistoryAuthor?, committer: CommitsHistoryAuthor?, parents: [Parent]?) {
        self.sha = sha
        self.nodeID = nodeID
        self.commit = commit
        self.url = url
        self.htmlURL = htmlURL
        self.commentsURL = commentsURL
        self.author = author
        self.committer = committer
        self.parents = parents
    }
}

// MARK: - CommitsHistoryAuthor
class CommitsHistoryAuthor: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url: String?
    let htmlURL: String?
    let followersURL: String?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    let subscriptionsURL: String?
    let organizationsURL: String?
    let reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url = "url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
    }

    init(login: String?, id: Int?, nodeID: String?, avatarURL: String?, gravatarID: String?, url: String?, htmlURL: String?, followersURL: String?, followingURL: String?, gistsURL: String?, starredURL: String?, subscriptionsURL: String?, organizationsURL: String?, reposURL: String?, eventsURL: String?, receivedEventsURL: String?, type: String?, siteAdmin: Bool?) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.htmlURL = htmlURL
        self.followersURL = followersURL
        self.followingURL = followingURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.siteAdmin = siteAdmin
    }
}

// MARK: - Commit
class Commit: Codable {
    let author: CommitAuthor?
    let committer: CommitAuthor?
    let message: String?
    let tree: Tree?
    let url: String?
    let commentCount: Int?
    let verification: Verification?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case committer = "committer"
        case message = "message"
        case tree = "tree"
        case url = "url"
        case commentCount = "comment_count"
        case verification = "verification"
    }

    init(author: CommitAuthor?, committer: CommitAuthor?, message: String?, tree: Tree?, url: String?, commentCount: Int?, verification: Verification?) {
        self.author = author
        self.committer = committer
        self.message = message
        self.tree = tree
        self.url = url
        self.commentCount = commentCount
        self.verification = verification
    }
}

// MARK: - CommitAuthor
class CommitAuthor: Codable {
    let name: String?
    let email: String?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case date = "date"
    }

    init(name: String?, email: String?, date: String?) {
        self.name = name
        self.email = email
        self.date = date
    }
}

// MARK: - Tree
class Tree: Codable {
    let sha: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case sha = "sha"
        case url = "url"
    }

    init(sha: String?, url: String?) {
        self.sha = sha
        self.url = url
    }
}

// MARK: - Verification
class Verification: Codable {
    let verified: Bool?
    let reason: String?
    let signature: String?
    let payload: String?

    enum CodingKeys: String, CodingKey {
        case verified = "verified"
        case reason = "reason"
        case signature = "signature"
        case payload = "payload"
    }

    init(verified: Bool?, reason: String?, signature: String?, payload: String?) {
        self.verified = verified
        self.reason = reason
        self.signature = signature
        self.payload = payload
    }
}

// MARK: - Parent
class Parent: Codable {
    let sha: String?
    let url: String?
    let htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case sha = "sha"
        case url = "url"
        case htmlURL = "html_url"
    }

    init(sha: String?, url: String?, htmlURL: String?) {
        self.sha = sha
        self.url = url
        self.htmlURL = htmlURL
    }
}


