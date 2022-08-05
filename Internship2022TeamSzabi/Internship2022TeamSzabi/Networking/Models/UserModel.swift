//
//  UserModel.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 30.07.2022.
//

import Foundation

struct UserModel: Codable {
    let email: String
    let name: String
    let personalID: String
    let studentID: String
    let photo: String?
}

struct Grades: Codable {
    let chapter: String
    let course: String
    let grade: Int
    let semester: Int
}
