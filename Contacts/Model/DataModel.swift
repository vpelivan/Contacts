//
//  DataModel.swift
//  Contacts
//
//  Created by Victor Pelivan on 27.05.2020.
//  Copyright © 2020 Victor Pelivan. All rights reserved.
//

import Foundation
import UIKit
import SwiftHash


// MARK: - Next structure simmulates random user
struct User {
    var emailServer: String! // Because Gravatar does not provide emails, to avoid spamming, I use this variable, which I randomly pick from RandomData class to simulate user's email adress
    var status: Bool! // Random online status
    var nickName: String! // Random nickName to assemble a random fake email adress
    var name: String! // Random Name
    var emailHash: String! // My Gravatar account hashed emails
    var image: UIImage? // Image being loaded later from Gravatar
    
    init() {
        randomizeData()
    }

    mutating func randomizeData() {
        let randomData = RandomData()

        self.emailHash = MD5("\(randomData.emailsArray.randomElement()!)").lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        self.name = randomData.namesArray.randomElement()!
        self.emailServer = randomData.serversArray.randomElement()!
        self.status = randomData.statusArray.randomElement()!
        self.nickName = randomData.nicksArray.randomElement()!
    }
}

// MARK: - Next class contains all data being used to initialize random data
private class RandomData {
    let namesArray: [String] = ["Mac Mendez", "Veer Wolfe", "Ella-Louise Mccall", "Walter Meyers", "Ebony Mckinney", "Hanna Mccoy", "Gwen Gentry", "Poppy-Mae Rodrigues", "Mahamed Alvarado", "Atticus Wright", "Brittney Barber", "Amrita Wallace", "Anabelle Cano", "Zakariyah Boone", "Devon Cunningham", "Zaine Stokes", "Hayleigh Rivas", "Saarah Campos", "Thiago Oconnell", "Shania Clements", "Hari O'Connor", "Ava-Grace Hamilton", "Shayne Nixon", "Faizaan Weir", "Can Christian", "Parker Giles", "Carwyn Crouch", "Polly Rawlings", "Ronnie Sadler", "Lowri Mata", "Macsen Ridley", "Adina Singh", "Kush Armstrong", "Gruffydd Halliday", "Maud Callahan", "Gideon Dudley", "Blanche Pace", "Lillie-Rose Dyer", "Kirby Mccann", "Nikhil Noel", "Nylah Trejo", "Clementine Mcghee", "Menachem Valdez","Sadie Smith", "Adrienne Stafford", "Harpreet Friedman", "Nyah Stacey", "Esmee Solomon", "Martina Banks", "Samanta Jeffery", "Howard Clayton", "Elsie-Rose Villa", "Suzannah Durham", "Bert Key", "Alfie-James Simon", "Victoria Martinez", "Tiago Foley", "Bevan Hassan", "Zak Mohammed", "Rikki Macfarlane", "Vanessa Herbert", "Patrycja Oneil", "Lucca Hook", "Ashanti Francis", "Hira Murphy", "Montel Jimenez", "Ffion Bouvet", "Vicki Houghton", "Octavia Neal", "Alfie-Lee Mcintyre", "Elliott Glass", "Rachelle Person", "Eleanor Hudson", "Seth Preston", "Rivka Mccray", "Aditi Rivers", "Patsy Rowley", "Dolcie Zavala", "Jayden-Lee Philip", "Safia Schmitt", "Athena Portillo", "Dennis Copeland", "Jarred Christie", "Kinga Metcalfe", "Heath Whitehead", "Salahuddin Dennis", "Lubna Bannister", "Lily-Rose Mackenzie", "Josef Kerr", "Konnor Ireland", "Kurtis Becker", "Sidrah Camacho", "Iosif Buckley", "Colleen Wilkes", "Mayson Riley", "Prince Clark", "Yousaf Carpenter", "Paige Hough", "Ahyan Cope", "Roger Vinson"]
    
    let nicksArray: [String] = ["Amigo", "BabyBrother", "BigBoy", "Biggie", "BlueEyes", "Braddah", "Bro277", "BrownEyes", "Bruv007", "Buddy", "Buster", "Captain", "Champ", "Chatterbox", "Chief", "Daddy-o", "Doc4ever", "FirstMate", "Gillegan", "Homie", "Homes", "HotShot", "Junior", "KidRock", "Laddie", "Little", "Money", "OzzyOhNo", "Partner", "Peanut", "Pickle", "Ranger", "Rocket", "Sidekick", "SlimTooth", "Sunshine", "Playboy", "Yankee", "BabyFace", "BigBear", "Canelo", "Charming", "Cheetah", "Cowboy", "Cutie", "Dimples", "Donut", "FirstMate", "Ginger", "Guapo", "Handsome", "Heartbreaker", "Hollywood", "Jaguar", "Lion", "Nugget", "Prettyboy", "Smiley", "Sparky", "Tiger", "WooBear", "Beavis", "Borat", "Butthead", "Caveman", "Chicken Butt", "Chubster", "Doofus", "Egghead", "Einstein", "Fun-sized", "Funnyman", "Goober", "Gumby", "Joker", "Meatball", "Money Bags", "Nibbles", "Oddball", "Scrappy-Doo", "Shorty", "Slim Shady", "Slowpoke", "Richie Rich", "Tater Tot", "Trouble", "Turtle", "Yoda", "Zippy", "Zorro", "Batman", "BlackPanther", "CaptainAmerica", "Chaos", "Cyclops", "Dr.Strange", "Drogo", "Dynamo", "Falcon", "IronMan"]
    
    let serversArray: [String] = ["@hotmail.com", "@yahoo.com", "@gmail.com", "@ukr.net", "@yandex.ru", "@mail.ru", "@outlook.com", "@aol.com", "@icloud.com", "@gmx.com"]
    
    let statusArray: [Bool] = [true, false]
    
    let emailsArray: [String] = ["pelivan.v.1988@gmail.com", "vpelivan42@gmail.com", "striver@mail.ru", "me.gtaddicted@gmail.com", "vpelivan@student.unit.ua", "ryha26+bob@gmail.com", "ryha26+linda@gmail.com", "ryha26+todd@gmail.com", "ryha26+mark@gmail.com"]
}
