//
//  DoubtView.swift
//
//
//  Created by Erick Ribeiro on 25/02/24.
//

import SwiftUI

struct DoubtView: View {
    
    @EnvironmentObject var earthCircleViewModel:EarthCircleViewModel
    
    var body: some View {
        ZStack {
            VStack{
                HStack {
                    HStack{
                        Text("{ Code Carbon }")
                            .font(.title3.bold())
                            .foregroundStyle(Color("bluePrimary"))
                    }
                    
                    Spacer()
                    
                    Button {
                        earthCircleViewModel.isDoubt = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .background(
                                Circle()
                                    .fill(Color(uiColor: .secondarySystemBackground))
                                    .frame(width: 32, height: 32)
                            )
                            .foregroundColor(Color(uiColor: .label))
                    }
                }
                .padding(.top, 15)
                .padding(.bottom, 10)
                .padding(.trailing, 30)
                .padding(.leading, 30)
                
                Divider()
                
                TabView {
                    DoubtViewPage1View()
                    DoubtViewPage2View()
                    DoubtViewPage3View()
                    DoubtViewPage4View()
                }
                .tabViewStyle(PageTabViewStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Close") {
                    earthCircleViewModel.isDoubt = false
                })
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .frame(maxWidth: SCENE_SIZE.width * 0.6, maxHeight: SCENE_SIZE.height * 0.85)
            
        }
        .frame(width: SCENE_SIZE.width, height: SCENE_SIZE.height)
        .background(
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    earthCircleViewModel.isDoubt = false
                }
        )
        .onAppear {
            setupAppearance()
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "bluePrimary")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

struct DoubtViewPage1View: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            HStack{
                Text("Welcome")
                    .font(.title.bold())
                    .foregroundColor(Color("goal"))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }.frame(maxWidth: .infinity, alignment: .center)
            
            Text("Are you ready to code for a cause? Introducing \"Code Carbon\", an app aimed at educating about climate change through the power of programming.")
            
            Text("In this initiative, we bring together technology and sustainability, harnessing the incredible potential of programming to address one of the most important issues of our time: high CO\u{2082} emissions and their devastating impact on our planet.")
            
            HStack{
                Image("emissionCOTutorial")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
            .padding(.top, 60)
            .frame(maxWidth: .infinity, alignment: .center)
        
            Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
    }
}

struct DoubtViewPage2View: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text("Balancing CO\u{2082} Emissions")
                    .font(.title.bold())
                    .foregroundColor(Color("goal"))
                    .padding(.top, 10)
                    .padding(.bottom, 20)
            }.frame(maxWidth: .infinity, alignment: .center)
            
            Text("Right now, our Earth is facing extreme CO\u{2082} imbalance. The visual representation you see reflects this imbalance: at the top are sectors emitting CO\u{2082}, while the graph illustrates this division—the top part depicting emissions, and the bottom part showing absorption.")
            
            HStack{
                Image("planetTutorial")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
                        
            Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
    }
}

struct DoubtViewPage3View: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text("Balancing CO\u{2082} Emissions")
                    .font(.title.bold())
                    .foregroundColor(Color("goal"))
                    .padding(.top, 10)
                    .padding(.bottom, 20)
            }.frame(maxWidth: .infinity, alignment: .center)
            
            
            Text("Our goal? To align this graph. Currently, emissions are at a whopping 421, but we need to bring them down to 350. That's the target.")

            Text("Here's how you do it: click on the sectors to see details. Each sector represents a different part of our activities, like transportation, energy, or industry. Each one also has a percentage impact on emissions and a CO\u{2082} reduction target. Your mission is to hit those reduction targets in all sectors to bring things back into balance.")
            
            HStack{
                Image("planetTutorial")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
                        
            Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
    }
}

struct DoubtViewPage4View: View {
    
    @EnvironmentObject var earthCircleViewModel:EarthCircleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Programming Your Sustainable Algorithm")
                    .font(.title.bold())
                    .foregroundColor(Color("goal"))
                    .padding(.top, 10)
                    .padding(.bottom, 20)
            }.frame(maxWidth: .infinity, alignment: .center)
            
            Text("Next, let's talk about programming your sustainable algorithm. Just click on the computer icon. Clicking on each sector will change the available actions, which are sustainable actions with both a CO\u{2082} reduction value and an Eco Points cost value. Speaking of Eco Points, those are the currency you'll use for each sustainable action.")
            
            Text("But wait, there's more! Each line of code you write comes with an additional bonus on the impact of the action on reducing CO\u{2082}. So, you'll need to manage your choices wisely and strategically, based on both Eco Points and the order of codes in each line.")
            
            Text("If you need to make changes, no problem! You can click on the selected codes to remove or change their order. When you click on a code and select another on the left, it adds the new code just below the selected one.")
            
            Text("Once you've programmed your sustainable algorithm, click on the button to execute. To succeed, you'll need to select codes in all available sectors, as each one has an impact on the scenario and a reduction target.")
            
            Text("After execution, you'll receive feedback in each sector. The planet's visual feedback will only change if you hit the change stops, illustrating how your choices impacted the scenery. Ready to give it a try?")
            
            HStack{
                Button(action: {
                    earthCircleViewModel.isDoubt = false
                }) {
                    Text("Save the Planet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }.frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
    }
}
