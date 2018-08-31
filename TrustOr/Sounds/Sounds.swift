//
//  Sounds.swift
//  Верю-Не-верю
//
//  Created by Dmitry Dementyev on 31.08.2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import AVFoundation

func initSound(mp3filename: String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: "ratchel.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        return player
    } catch {
        print("couldn't load file \(mp3filename)")
        return nil
    }
}
func initSound2(mp3filename: String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: "ding.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        return player
    } catch {
        print("couldn't load file \(mp3filename)")
        return nil
    }
}
