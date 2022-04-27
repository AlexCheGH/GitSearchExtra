//
//  Localization.swift
//  GitSearchExtra
//
//  Created by Aliaksandr Chekushkin on 4/25/22.
//

import Foundation

struct Localization {
    
    struct Label {
        static let search = NSLocalizedString("search_label", comment: "")
        static let repository = NSLocalizedString("repository_label", comment: "")
        static let repoTitle = NSLocalizedString("repo_title_lable", comment: "")
        static let commitsHistory = NSLocalizedString("commits_history_label", comment: "")
        static let repoBy = NSLocalizedString("repo_by", comment: "")
        static let notAvailable = NSLocalizedString("n_a", comment: "")
    }
    
    struct Button {
        static let shareRepo = NSLocalizedString("share_repo_button", comment: "")
        static let back = NSLocalizedString("back_button", comment: "")
        static let viewOnline = NSLocalizedString("view_online_button", comment: "")
        static let open = NSLocalizedString("open", comment: "")
        static let cancel = NSLocalizedString("cancel", comment: "")
    }
    
    struct TextFieldPrompt {
        static let prompt = NSLocalizedString("start_typing_prompt", comment: "")
    }
    
    struct AlertPrompt {
        static let externalLink = NSLocalizedString("external_link_prompt", comment: "")
    }
    
    struct Texts {
        static let nummberOfStars = NSLocalizedString("number_of_stars", comment: "")
        static let somethingWrong = NSLocalizedString("something_went_wrong", comment: "")
    }
    
}


