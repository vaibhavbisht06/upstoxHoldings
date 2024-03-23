import Combine
import Foundation

class ContentViewModel: ObservableObject {
    // Create a publisher for posts
    @Published var EquityData: UserHolding? = nil
    @Published var CurrentValue : Float = 0.0
    @Published var TotalInvestment : Float = 0.0
    @Published var TodayPL : Float = 0.0
    @Published var PLPorfolio : Float = 0.0
    
    private var cancellable: AnyCancellable?

    func fetchPosts(completion: @escaping(Bool) -> Void) {
        guard let url = URL(string: AppConstant.baseURL) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLSession data task publisher
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UserHolding.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Network request completed successfully")
                case .failure(let error):
                    print("Failed to fetch posts: \(error)")
                }
            }, receiveValue: { [weak self] Equity in
                self?.EquityData = Equity
                self?.updateAccumulatedData()
                completion(true)
            })
    }
    func updateAccumulatedData(){
        let  arrayPerShareCurrentValue = EquityData?.userHolding.map{($0.ltp ?? 0.0) * Float($0.quantity ?? 1)}
        self.CurrentValue = arrayPerShareCurrentValue?.reduce(0.0 , {$0 + $1}) ?? 0.0
        let arrayPerShareInvestment = EquityData?.userHolding.map{($0.avgPrice ?? 0.0) * Float($0.quantity ?? 1)}
        self.TotalInvestment = arrayPerShareInvestment?.reduce(0.0 , {$0 + $1}) ?? 0.0
        self.PLPorfolio = self.CurrentValue - self.TotalInvestment
        let arrayPerShareTodayPL = EquityData?.userHolding.map{(($0.close ?? 0.0) - ($0.ltp ?? 0.0)) * Float($0.quantity ?? 1)}
        self.TodayPL = arrayPerShareTodayPL?.reduce(0.0 , {$0 + $1}) ?? 0.0
    }
}
