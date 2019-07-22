//
//  BusDAO.swift
//  MapKit-Template
//
//  Created by Matheus Gois on 22/07/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation


struct Bus: Codable{
    let cl: Int // Código identificador da linha. Este é um código identificador único de cada linha do sistema (por sentido de operação)
    let lc: Bool // Indica se uma linha opera no modo circular (sem um terminal secundário)
    let lt: String // Informa a primeira parte do letreiro numérico da linha
    let sl: Int //Informa a segunda parte do letreiro numérico da linha, que indica se a linha opera nos modos: BASE (10), ATENDIMENTO (21, 23, 32, 41)
    let tl: Int // Informa o sentido ao qual a linha atende, onde 1 significa Terminal Principal para Terminal Secundário e 2 para Terminal Secundário para Terminal Principal
    let tp: String // Informa o letreiro descritivo da linha no sentido Terminal Principal para Terminal Secundário
    let ts: String // Informa o letreiro descritivo da linha no sentido Terminal Secundário para Terminal Principal
}
// Exemplo
//"cl: 220,
//"lc": true,
//"lt": "2713",
//"sl": 1,
//"tl": 10,
//"tp": "CHÁC. BELA VISTA",
//"ts": "METRÔ PENHA"
