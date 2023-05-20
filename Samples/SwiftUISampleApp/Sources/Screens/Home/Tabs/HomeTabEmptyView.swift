//
//  HomeTabEmptyView.swift
//  
//
//  Created by Adnan ilker Ozcan on 29.08.2022.
//

import SwiftUI

struct HomeTabEmptyView: View {
    
    // MARK: - Body
    
    var body: some View {
        Spacer()
    }
}

#if DEBUG
struct HomeTabEmptyView_Previews: PreviewProvider {
    
    struct HomeTabEmptyViewDemo: View {
        
        var body: some View {
            HomeTabEmptyView()
        }
    }
    
    static var previews: some View {
        prepare()
        return HomeTabEmptyViewDemo()
    }
}
#endif
