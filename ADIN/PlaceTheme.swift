//
//  PlaceTheme.swift
//  ADIN
//
//  Created by Islam on 10.07.17.
//  Copyright © 2017 Islam Temirbek. All rights reserved.
//

enum PlaceTheme: String {
    
    case fitness = "Фитнес"
    case girls = "Девушки"
    case cooking = "Кулинария"
    case humor = "Юмор"
    case travels = "Путешествия"
    case entertainment = "Развлечения"
    case auto = "Авто"
    case lifeHack = "Лайфхак"
    case quotes = "Цитаты"
    case photos = "Фотографии"
    case womans = "Женское"
    case cinema = "Кино"
    case video = "Видео"
    case fashion = "Мода"
    case animals = "Животные"
    case motivation = "Мотивация"
    case tatoo = "Тату"
    case design = "Дизайн"
    case interior = "Интерьер"
    case regional = "Региональное"
    case science = "Наука"
    case horoscope = "Гороскоп"
    case peronal = "Личная страница"
    case news = "Новости"
    case vine = "Вайн"
    case dance = "Танцы"
    
    static var all: [PlaceTheme] {
        return [.fitness, .girls, .cooking, .humor,
                .travels, .entertainment, .auto,
                .lifeHack, .quotes, .photos, .womans,
                .cinema, .video, .fashion, .animals,
                .motivation, .tatoo, .design, .interior,
                .regional, .science, .horoscope, .peronal,
                .news, .vine, .dance
               ].sorted { $0.rawValue < $1.rawValue }
    }
}

