//
//  ProjectRow.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/1.
//

import Kingfisher
import SwiftUI
import Then

struct ProjectRow: View {

    let project: Project

    var body: some View {
        HStack {
            KFImage(URL(string: project.envelopePic ?? ""))
                .renderingMode(.original)
                .resizable()
                .placeholder({ progress in
                    Spacer()
                        .frame(width: 80, height: 80)
                        .background(Color.gray)
                        .cornerRadius(8)
                })
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .aspectRatio(1, contentMode: .fill)
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text(project.title ?? "")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .lineLimit(2)
                HStack(spacing: 8) {
                    Text(project.author ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    Text(project.shareDateStr())
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            Spacer()
        }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .frame(height: 90)
    }
}

struct ProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRow(project: Project())
    }
}
