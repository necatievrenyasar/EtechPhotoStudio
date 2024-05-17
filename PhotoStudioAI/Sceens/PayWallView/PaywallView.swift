//
//  PaywallView.swift
//  PhotoStudioAI
//
//  Created by Evren Yaşar on 17.05.2024.
//

import Foundation
import SwiftUI

struct PaywallView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) private var openURL
    @StateObject var viewModel = PaywallVM()
    
    var body: some View {
        content
    }
}

extension PaywallView {
    
    var content: some View {
        ScrollView {
            VStack(spacing: 16) {
                topButtons
                topImage
                features
                productRows
                puchaseButton.padding(.top, 8)
                termsButtons
            }.padding(.horizontal, 24)
        }.background(Color.gray1)
    }
    
}

extension PaywallView {
    
    var topButtons: some View {
        HStack {
            Button {
                //viewModel.restore()
            } label: {
                Text("Restore").font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.vertical,4)
                    .padding(.horizontal,10)
                    .background(
                        Color.white.opacity(0.2)
                            .cornerRadius(8)
                    )
            }
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(
                        Color.black
                            .cornerRadius(16)
                    )
            }
        }
    }
    
    var topImage: some View {
        Color.gray.frame(height: 200).cornerRadius(16)
    }
    
    var features:some View {
        VStack(spacing:16) {
            HStack(spacing: 0) {
                Image(systemName: "checkmark.circle")
                Text("No watermark, unlimited pro tools")
                Spacer()
            }
            
            HStack(spacing: 0) {
                Image(systemName: "checkmark.circle")
                Text("Advanced background remover")
                Spacer()
            }
            
            HStack(spacing: 0) {
                Image(systemName: "checkmark.circle")
                Text("Unlock 1000+ pro templates")
                Spacer()
            }
        }
    }
    
    
    var productRows: some View {
        VStack {
            ForEach(viewModel.rows, id:\.title) { item in
                PaywallPlanRow(model: item)
            }
        }
    }
    
    var puchaseButton: some View {
        Button {
            //viewModel.makePuchase()
        } label: {
            HStack {
                Spacer()
                Text("Continue")
                    .font(.callout)
                    .textCase(.uppercase)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(height: 50)
            .background(Color.purple1).cornerRadius(16)
        }
    }
    
    var termsButtons: some View {
        HStack {
            Button(action: {
                openURL(URL(string: "https://www.termsfeed.com/live/6f9e343f-00bb-4769-acdf-58d51b3e0ab6")!)
            }, label: {
                Text("Privacy")
                    .font(.caption)
                    .foregroundColor(.black)
            })
            Text("|")
                .font(.caption)
                .foregroundColor(.black)
            
            Button(action: {
                openURL(URL(string: "https://www.termsfeed.com/live/6f9e343f-00bb-4769-acdf-58d51b3e0ab6")!)
            }, label: {
                Text("Terms")
                    .font(.caption)
                    .foregroundColor(.black)
            })
            Spacer()
            Text("Cancel Anytime")
                .font(.caption)
                .foregroundColor(.black.opacity(0.5))
            
        }.padding(.horizontal, 8)
    }
}

#Preview {
    PaywallView()
}

