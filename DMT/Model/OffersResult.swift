//
//  OffersResult.swift
//  DMT
//
//  Created by Synergy on 21/06/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

import Foundation

/*
{"msg":"success",
    "response":"Operatiune desfasurata cu succes.",
    "result":[
    {
    "id_user":"1",
    "id_oferta":"2",
     "cod_specializare":"1",
     "specializare":"Om bun",
     "cod_locatie":"1",
     "nume_locatie":"Galati",
     "titlu_oferta":"Ingrijit vaci",
     "pret_oferta":"35"
     },
    {"id_user":"3","id_oferta":"3","cod_specializare":"1","specializare":"Om bun","cod_locatie":"1","nume_locatie":"Galati","titlu_oferta":"Spart geamuri","pret_oferta":"35"},
    {"id_user":"4","id_oferta":"4","cod_specializare":"1","specializare":"Om bun","cod_locatie":"1","nume_locatie":"Galati","titlu_oferta":"Urmarit pisici","pret_oferta":"71"},
    {"id_user":"29","id_oferta":"5","cod_specializare":"1","specializare":"Om bun","cod_locatie":"1","nume_locatie":"Galati","titlu_oferta":"Aruncat cu sulite in cer","pret_oferta":"35"},
    {"id_user":"35","id_oferta":"6","cod_specializare":"1","specializare":"Om bun","cod_locatie":"1","nume_locatie":"Galati","titlu_oferta":"Distrus cladiri","pret_oferta":"35"}
    ]
}
 
 */

struct OffersDetail:Codable {
    let idUser: String?
    let idOferta: String?
    let codSpecializare: String?
    let specializare: String?
    let codLocatie: String?
    let numeLocatie: String?
    let titluOferta: String?
    let pretOferta: String?
    
    private enum CodingKeys: String, CodingKey{
        case idUser = "id_user"
        case idOferta = "id_oferta"
        case codSpecializare = "cod_specializare"
        case specializare
        case codLocatie = "cod_locatie"
        case numeLocatie = "nume_locatie"
        case titluOferta = "titlu_oferta"
        case pretOferta = "pret_oferta"

    }
}

struct OffersResult: Codable{
    let msg: String? // "ERROR" sau "SUCCESS"
    let response: String? // "Operatiune desfasurata cu succes."
    let result:[OffersDetail]?
}


