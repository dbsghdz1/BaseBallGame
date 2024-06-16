//
//  main.swift
//  NumberBaseball
//
//  Created by 김윤홍 on 6/11/24.
//

let pb = PlayBall(messageHandler: Message(), numberSystem: Number(), inputValidator: InputValidator(), randomNumberGenerator: RandomNumberGenerator())
pb.gameStart()
