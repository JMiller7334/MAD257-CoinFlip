//
//  ContentView.swift
//  MAD257-CoinFlip Watch App
//
//  Created by student on 2/23/23.
//

import SwiftUI

struct ContentView: View {
    @State var displayText :String = "Coin Flip"
    
    let messages = ["Flipping the coin.", "Flipping the coin..", "Flipping the coin..."]
    
    func coinFlip(){
        //creates a queue with delay. This does not work with for loops thanks to language behavior.
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            displayText = "Flipping coin"
            
            // Creates a repeating loop like a for loop w/delays -- This method works over dispatchQueue
            var i = 0
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ intervals in
                print("timer: \(i)")
                displayText = messages[i]
                i += 1
                if i >= messages.count {
                    intervals.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                        let result = Bool.random()
                        if (result == true){
                            displayText = "Result: Heads"
                        } else {
                            displayText = "Result: Tails"
                        }
                    })
                }
            }
            
        })
    }
    
    var body: some View {
        VStack {
            Text(displayText)
            Button("Flip", action: {
                coinFlip()//calls the coinFlip() method on button press/tap.
            })
           
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
