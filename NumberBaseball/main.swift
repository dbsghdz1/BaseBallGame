//
//  main.swift
//  NumberBaseball
//
//  Created by 김윤홍 on 6/11/24.
//

let playBall = PlayBall(messageHandler: Message(), numberSystem: Number(), inputValidator: InputValidator(), randomNumberGenerator: RandomNumberGenerator())
playBall.gameStart()
