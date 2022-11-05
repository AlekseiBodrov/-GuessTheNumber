//
//  Manager.swift
//  GuessTheNumber
//
//  Created by Алексей on 01.11.2022.
//

import Foundation

enum Button {
    case more
    case equal
    case less
}

enum Winner: String {
    case user = "You Win"
    case computer  = "Computer Win"
    case draw  = "It's a draw"
}

class Manager{

    //MARK: - var/let
    static var winner: Winner!

    static var userNumberOfTries: Int!
    static var userPickNumber: Int!
    static var userCurrentTryGuess: Int!

    static var computerNumberOfTries : Int!
    static var computerPickNumber: Int!

    static var minNumber: Int!
    static var maxNumber: Int!
    static var computerCurrentTry : Int!


}

extension Manager {
    //MARK: - flow funcs
    static func checkNumber (_ button:Button) {
        computerNumberOfTries += 1

        switch button {
        case .more:
            minNumber = computerCurrentTry + 1
            computerCurrentTry = Int.random(in: minNumber...maxNumber)

        case .equal:
            print(computerCurrentTry as Any)

        case .less:
            maxNumber = computerCurrentTry - 1
            computerCurrentTry = Int.random(in: minNumber...maxNumber)
        }
    }

    static func setDefaultProperties() {

        winner = .draw

        userNumberOfTries = 0
        userPickNumber = 0
        userCurrentTryGuess = 0

        computerNumberOfTries = 0
        computerPickNumber = Int.random(in: 0...100)

        minNumber = 0
        maxNumber = 100
        computerCurrentTry = Int.random(in: minNumber...maxNumber)
    }

    static func selectWinner() {
        if userNumberOfTries < computerNumberOfTries {
            winner = .user
        } else if userNumberOfTries > computerNumberOfTries {
            winner = .computer
        } else {
            winner = .draw
        }
    }

}

