//
//  ClickedOffer.swift
//  DMT
//
//  Created by Boza Rares-Dorian on 04/07/2018.
//  Copyright © 2018 Boggy. All rights reserved.
//

//"msg":"success",
//"response":"Operatiune desfasurata cu succes.",
//    "result":[{
//    "id_oferta":"5",
//    "data_expirare_oferta":"2019-07-04",
//    "cod_specializare":"1",
//    "specializare":"Om bun",
//    "cod_locatie":"1","
//    "nume_locatie":"Galati",
//    "titlu_oferta":"Aruncat cu sulite in cer",
//    "descriere_oferta":"Caut om sa arunce cu sulitele ca spartanii",
//    "pret_oferta":"35",
//    "count_images":"1",
//    "imagine_oferta_1":"iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAQAAAC0NkA6AAAABGdBTUEAALGPC\/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA\/4ePzL8AAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAHdElNRQfiBR8QDTmhT42lAAAD9klEQVRYw+3VbWiWZRQH8N\/zzPmOc9PNreXSMtOy1JLM15aGEJmN0ihL+6BkUVQGYUmGEIJB4QuRVqSFRlSUZCW+iyFGmhGiQ8MUtTC3dOrS2p7nue8+ePs059ya2+yL\/0\/nXNd1n\/\/5X\/c55+IKruAKGkJGI8\/HFYr7uyVT6uQ5e601UrxlCGIG+VK1pMBRs3RtCQ3POyRU6kkLnJKyvnn1nNWQcMZSvZGpxA5hc+rJSmuYpG16taj59MQMslLCGUv0rrXXTHqyTHdYqNREbeo8UWiek03R86+GG\/SQF63GXS83sjP0kmecHyI9OY2l6G6n0G6Pae06uyzXGtxor\/e0AgPtt1BMd\/OdEJrbWJJrHHDS3WC8pH16gklCuxWCaUI\/ykMrC4UWXSzYxcZKYIy+OjjuVjNdpbN8FQZ7WZ4cuU4YboaucmWrVGyKHB\/Y3hgdheY5JRSokpC00W6hKkkJ6+yJ7Cqr7YvsQGin8dGlNqgkwxiLjHfcPN8L\/GyxWVapkrDHW161VkK1UgvMtkFStZ+86y\/DjJVnl1MNacj1mmNS1hsuLqZtunhj2qXzjNeyM9HJC34T2ubeqDDqRNwIGwX+MPuS2ivmDqulVJirW91HOpvhd4EtRjdhUOR4RZnAt0ZdGGWQryVVeF2+mJuigj2r72ZFNf5Y\/6iAIdNA+Wmvtdvkiim2WaCsdnv2tKvGbRbZbbWO0V5v+3yRHo23OGSZzMgb7IjF6YyLlXsTdDPHMaE3apJcba9qEyPvYVXKDIm8KVJ+NSDynhX6RZ\/ImylUGqmOmyO0I9LZ3mdC88\/Jh0qFRuorLkeJl3TVwUDkmeBFWToZKJDvUdN1lK2\/QKHHPaO9rvoJFJlqmna66SvQwxMmqDTbwZpaCnyiWigpUGWZrySEUkJ\/et8aycg76R2bpASSQqe8bYtAICVUbqFtAgnVQmWePteFsRrVNdZoPQ11wCinlbhLlsO+sVFH97tTlkNW2STHA4bp5XYbjJPtQUO1t88KWxWY6SkHfWqFbVK1Sc6in43KFStHZ0OQlIGU1lo5avu5D91jpXVKVCNDTEoY\/dGPLTc58uCC3kzWsIss0UU8SiQQs9l9ztRxMlUrSni+W88AENPGGVslEOpiWLp0G4lW9e7G7TdZhZiU4dZcGkVDJISS0WUkGw528VwvAy4LSf3XFcpW4jQCfRq82ksiiQn0tLRllVT4PD2LIa70vI4IFXioVkEEhjaO5KBptSZCeF6bBQZY1lQltYOejyM+qqM5A9ca0TiS+rDL1DrTeqQ5SVxEZR2r\/1OfhLJNVHnBI\/DfkEo\/2w2QFJx7m1tKyQkf6tTEmHHf1VOVLYV\/ANx7UVTsXuHhAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE4LTA1LTMxVDE2OjEzOjU3LTA0OjAww20gqAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOC0wNS0zMVQxNjoxMzo1Ny0wNDowMLIwmBQAAAAASUVORK5CYII=",
//    "nume_angajator":"Micu"}]}
import Foundation

struct ClickedOfferDetail: Codable {
    
    let idOferta: String?
    let dataExpirareOferta: String?
    let codSpecializare: String?
    let specializare: String?
    let codLocatie: String?
    let numeLocatie: String?
    let titluOferta: String?
    let descriereOferta: String?
    let pretOferta: String?
    let countImages: String?
    let imagineOferta1: String?
    let imagineOferta2: String?
    let imagineOferta3: String?
    let numeAngajator: String?
    
    private enum CodingKeys: String, CodingKey{

        case idOferta = "id_oferta"
        case dataExpirareOferta = "data_expirare_oferta"
        case codSpecializare = "cod_specializare"
        case specializare
        case codLocatie = "cod_locatie"
        case numeLocatie = "nume_locatie"
        case titluOferta = "titlu_oferta"
        case descriereOferta = "descriere_oferta"
        case pretOferta = "pret_oferta"
        case countImages = "count_images"
        case imagineOferta1 = "imagine_oferta_1"
        case imagineOferta2 = "imagine_oferta_2"
        case imagineOferta3 = "imagine_oferta_3"
        case numeAngajator = "nume_angajator"
    }
    
}

struct ClickedOfferResult: Codable {
    let msg: String?
    let response: String?
    let result: ClickedOfferDetail?
}
