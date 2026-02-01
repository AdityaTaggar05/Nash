# Nash
**Prediction Markets for Friend Groups**

> *Combine the tension of high-stakes prediction with the banter of your inner circle.*

![Nash Banner](/app/assets/logo.jpg) 
## Inspiration
We wanted to gamify the "I told you so" moments in friend groups. Existing betting apps are too transactional or focused on sports. **Nash** is designed to let you bet on *anything*, from "Will Team Commitment Issues win Merge Conflict '26?" to "Will the code compile on the first try?", all while managing an economy that rewards active participation.

## Key Features

* **Custom Bets:** Create bets on any topic limited only by your imagination.
* **Keeping Interactions Bet-Specific:** We intentionally removed Group chats. Instead, every specific bet has its own dedicated discussion tab, keeping the trash talk focused on the stakes at hand.
* **Real-Time Updates:** Powered by **Socket.io**, bet statuses (Open/Locked/Resolved) and pot values update instantly across all devices.
* **Realisitic Economy:** A carefully balanced in-game currency system designed to prevent inflation and reward active creators.

## The Nash Economy

We built a self-sustaining economic model to keep the value of Nash coins regulated:

| Action | Economic Effect | Logic |
| :--- | :--- | :--- |
| **First Login** | `+500 Nash` (Injection) | Initial balance to let the ball rolling! |
| **Daily Login** | `+100 Nash` (Injection) | Keeps users coming back daily. |
| **Create Bet** | `-150 Nash` (Sink) | A fee to keep spammers away. |
| **The "House"** | `18% Decay` (Nirmala Tai Fee) | Removed from the winning pot to control inflation. |
| **Creator Cut** | `2% Reward` (Incentive) | The creator gets 2% of the total pot, which encourages them to create more bets. |

## Tech Stack

### Frontend (Mobile)
* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** [Riverpod](https://riverpod.dev/) (for robust async state handling)
* **Networking:** Dio
* **UI:** Material Design 3

### Backend (API & Real-time)
* **Runtime:** [Node.js](https://nodejs.org/)
* **Language:** TypeScript
* **Framework:** Express.js
* **Real-time:** Socket.io (for live pot updates and chat)
* **Database:** PostgreSQL (handling relational data and financial transactions)

## How It Works

1. **Group Creation:** Group creator (Admin) adds his/her friends to the created group.
2.  **Create:** Any one of the user pays **150 Nash** to open a new bet (e.g., "Will Dhoni retire this IPL?").
3.  **Bet:** The users predict (except the creator, coz why?)
4.  **Lock:** Once the time limit is reached, the bet is **Locked**. No new bets can be placed.
5.  **Resolve:** The Creator acts as the Resolver and announces the result.
6.  **Payout:** 
    * 2% goes to the Creator.
    * 18% is burned (removed from economy).
    * 80% is distributed to the winners proportional to their contribution in the winning part of the pot.

## 📸 Screenshots

| Home Feed | Bet Page | Discussion Thread | Profile |
|:---:|:---:|:---:|:---:|
| ![Home]() | ![Bet]() | ![Chat]() | ![Profile]() |