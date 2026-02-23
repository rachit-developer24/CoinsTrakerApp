# CoinsTracker 📈

A production-style iOS cryptocurrency price tracker built with SwiftUI, featuring real-time CoinGecko API data, infinite scroll pagination, intelligent caching, 429 rate-limit handling, and full XCTest coverage.

---

## Screenshots

<img width="721" height="862" alt="Screenshot 2026-02-23 at 02 32 44" src="https://github.com/user-attachments/assets/5c1419d3-f657-443e-a4a6-167283daf8ae" />
<img width="874" height="872" alt="Screenshot 2026-02-23 at 02 33 20" src="https://github.com/user-attachments/assets/7c85c50c-5c2b-4642-8998-73b941e40187" />
<img width="812" height="865" alt="Screenshot 2026-02-23 at 02 33 52" src="https://github.com/user-attachments/assets/32e3be9b-86e8-4ef0-89c9-2b08dab21591" />
<img width="714" height="883" alt="Screenshot 2026-02-23 at 02 34 20" src="https://github.com/user-attachments/assets/c0249e89-263c-4173-aac1-70648b6af39f" />


---

## Features

- 📊 **Live crypto prices** — fetches top coins by market cap via CoinGecko API
- 🔍 **Search** — filter coins by name or symbol in real time
- 📄 **Coin detail view** — description, symbol, and image for each coin
- ♾️ **Infinite scroll pagination** — loads more coins as you scroll, with duplicate-request protection
- 💾 **NSCache layer** — coin details cached in memory, eliminating redundant network calls on back navigation
- 🔁 **429 rate-limit handling** — detects HTTP 429, shows a UI overlay, waits 20 seconds, and retries automatically
- ⚠️ **Typed error handling** — `CoinsApiError` enum covers invalid URL, invalid data, status codes, and unknown errors
- ✅ **XCTest unit tests** — ViewModel tests covering successful fetch, invalid JSON, error types, and sort order

---

## Architecture

```
CoinsTracker/
├── Models/
│   ├── Coin.swift
│   └── CoinDetails.swift
├── Services/
│   ├── CoinsServiceProtocol.swift
│   ├── CoinsService.swift          # Real API + NSCache
│   ├── CoinsMockService.swift      # For unit tests
│   └── HttpDataDownloader.swift    # Generic reusable network layer
├── ViewModels/
│   ├── CoinsViewModel.swift        # Pagination + rate limit logic
│   └── CoinsDetailViewModel.swift
├── Views/
│   ├── CoinsView.swift
│   ├── CoinsSubView.swift
│   ├── CoinDetailView.swift
│   └── ChangePill.swift            # +/- percentage badge
├── Utilities/
│   ├── CoinsApiError.swift
│   ├── ContentLoadingState.swift
│   └── Double+Extensions.swift
└── Tests/
    ├── CoinsViewModelTests.swift
    └── CoinsPriceTrackerTests.swift
```

**Pattern:** MVVM · Protocol-oriented DI · `@MainActor` ViewModels · `async/await`

---

## Technical Highlights

### Generic Networking Layer
```swift
protocol HttpDataDownloader {
    func fetchData<T: Codable>(as type: T.Type, with endpoint: String) async throws -> T
}
```
One reusable extension handles all decoding — no duplicated URLSession code.

### Pagination with Rate-Limit Protection
```swift
// Prevents duplicate requests
guard !isPaginating else { return }

// Detects real 429 and backs off for 20 seconds
if case .invalidStatusCode(let code) = err, code == 429 {
    isRateLimited = true
    nextAllowedFetch = Date().addingTimeInterval(20)
    retryTask = Task { [weak self] in
        try? await Task.sleep(nanoseconds: 20_000_000_000)
        await self?.fetchCoins()
    }
}
```

### NSCache for Coin Details
```swift
class CoinsDetailsCache {
    static let shared = CoinsDetailsCache()
    let cache = NSCache<NSString, NSData>()
    // Encode CoinDetails → NSData on set, decode on get
}
```
Navigating back and forward to the same coin detail never triggers a redundant API call.

---

## Unit Tests

| Test | What it covers |
|------|---------------|
| `testSuccessfulCoinsFetch` | Coins load and count matches mock data |
| `testCoinFetchWithInvalidJSON` | Invalid JSON sets error state, coins remain empty |
| `testThrowsInvalidDataError` | Correct error type surfaced to ViewModel |
| `testThrowsInvalidStatusCodeError` | Status code errors handled correctly |
| `testDecodeCoinsIntoArray_MarketCapDesc` | JSON decodes correctly and sort order is preserved |

---

## Tech Stack

| | |
|---|---|
| **Language** | Swift 5.9 |
| **UI** | SwiftUI |
| **Architecture** | MVVM |
| **Networking** | URLSession + async/await |
| **Caching** | NSCache |
| **API** | [CoinGecko API](https://www.coingecko.com/en/api) |
| **Testing** | XCTest |
| **Image Loading** | Kingfisher |

---

## Getting Started

1. Clone the repo
```bash
git clone https://github.com/rachit-developer24/CoinsTrakerApp.git
```
2. Open `CoinsTrakerApp.xcodeproj` in Xcode
3. Run on simulator or device — no API key required (CoinGecko free tier)

> **Note:** The free CoinGecko API has rate limits. The app handles 429 responses automatically.

---

## Roadmap

- [ ] Price charts (sparkline data)
- [ ] Portfolio tracker with local persistence
- [ ] Price change alerts via local notifications
- [ ] Favourites list

---

## Author

**Rachit Matolia** — Junior iOS Developer, London  
[GitHub](https://github.com/rachit-developer24) · [LinkedIn](https://linkedin.com/in/rachit-matolia-085b3b261)
