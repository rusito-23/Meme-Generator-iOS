//
//  SwiftyBeaver.swift
//  MemeGenerator
//
//  Created by Igor Andruskiewitsch on 01/03/2019.
//  Copyright © 2019 Igor Andruskiewitsch. All rights reserved.
//
import Foundation
import SwiftyBeaver


// direct access to the logger across the app
let logger = SwiftyBeaver.self

extension SwiftyBeaver {

    static func setUpConsole() {
        let console = ConsoleDestination()

        console.levelColor.verbose = "⚪️ "
        console.levelColor.debug = "☑️ "
        console.levelColor.info = "🔵 "
        console.levelColor.warning = "🔶 "
        console.levelColor.error = "🔴 "

        logger.addDestination(console)

    }

}
