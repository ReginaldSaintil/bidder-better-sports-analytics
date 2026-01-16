-- ==========================================================
-- BidderBetter Full PostgreSQL Schema
-- ==========================================================

-- ========== 0. API Data Tables (SportsDataIO) ==========

-- Current Season
CREATE TABLE IF NOT EXISTS CurrentSeason (
  Season                 INTEGER PRIMARY KEY,
  StartYear              INTEGER NOT NULL,
  EndYear                INTEGER NOT NULL,
  Description            TEXT,
  RegularSeasonStartDate TIMESTAMP,
  PostSeasonStartDate    TIMESTAMP,
  SeasonType             TEXT,
  ApiSeason              TEXT
);

-- Players
CREATE TABLE IF NOT EXISTS Players (
  PlayerID              INTEGER PRIMARY KEY,
  Status                TEXT,
  TeamID                INTEGER,
  Team                  TEXT,
  Jersey                INTEGER,
  PositionCategory      TEXT,
  Position              TEXT,
  FirstName             TEXT,
  LastName              TEXT,
  Height                INTEGER,
  Weight                INTEGER,
  BirthDate             DATE,
  College               TEXT,
  PhotoUrl              TEXT,
  Experience            INTEGER,
  InjuryStatus          TEXT,
  FanduelPlayerID       INTEGER,
  DraftKingsPlayerID    INTEGER,
  FanDuelName           TEXT,
  DraftKingsName        TEXT
);

-- Teams
CREATE TABLE IF NOT EXISTS Teams (
  TeamID                  INTEGER PRIMARY KEY,
  Key                     TEXT,
  Active                  BOOLEAN,
  City                    TEXT,
  Name                    TEXT,
  LeagueID                INTEGER,
  StadiumID               INTEGER,
  Conference              TEXT,
  Division                TEXT,
  PrimaryColor            TEXT,
  SecondaryColor          TEXT,
  TertiaryColor           TEXT,
  QuaternaryColor         TEXT,
  WikipediaLogoUrl        TEXT,
  WikipediaWordMarkUrl    TEXT
);




-- PlayerGameStatsByDate
CREATE TABLE PlayerGameStatsByDate (
  stat_id                 INTEGER PRIMARY KEY,
  team_id                 INTEGER,
  player_id               INTEGER,
  season_type             INTEGER,
  season                  INTEGER,
  name                    TEXT,
  team                    TEXT,
  position                TEXT,
  started                 BOOLEAN, -- CHANGED TO INTEGER TO MATCH API
  injury_status           TEXT,
  game_id                 INTEGER,
  opponent_id             INTEGER,
  opponent                TEXT,
  day                     DATE,
  date_time               TIMESTAMP,
  home_or_away            TEXT,
  games                   INTEGER,
  fantasy_points          NUMERIC,
  minutes                 INTEGER,
  seconds                 INTEGER,
  field_goals_made        NUMERIC,
  field_goals_attempted   NUMERIC,
  field_goals_pct         NUMERIC,
  two_pointers_made       NUMERIC,
  two_pointers_attempted  NUMERIC,
  two_pointers_pct        NUMERIC,
  three_pointers_made     NUMERIC,
  three_pointers_attempted NUMERIC,
  three_pointers_pct      NUMERIC,
  free_throws_made        NUMERIC,
  free_throws_attempted   NUMERIC,
  free_throws_pct         NUMERIC,
  offensive_rebounds      NUMERIC,
  defensive_rebounds      NUMERIC,
  rebounds                NUMERIC,
  assists                 NUMERIC,
  steals                  NUMERIC,
  blocked_shots           NUMERIC,
  turnovers               NUMERIC,
  personal_fouls          NUMERIC,
  points                  NUMERIC,
  fantasy_points_fanduel  NUMERIC,
  fantasy_points_draftkings NUMERIC,
  plus_minus              NUMERIC,
  double_doubles          NUMERIC,
  triple_doubles          NUMERIC
);

ALTER TABLE PlayerGameStatsByDate
ALTER COLUMN started TYPE INTEGER USING started::integer;

-- PlayerSeasonStats
CREATE TABLE PlayerSeasonStats (
  stat_id                 INTEGER PRIMARY KEY,
  team_id                 INTEGER,
  player_id               INTEGER,
  season_type             INTEGER,
  season                  INTEGER,
  name                    TEXT,
  team                    TEXT,
  position                TEXT,
  started                 INTEGER,
  games                   INTEGER,
  fantasy_points          NUMERIC,
  minutes                 INTEGER,
  seconds                 INTEGER,
  field_goals_made        NUMERIC,
  field_goals_attempted   NUMERIC,
  field_goals_pct         NUMERIC,
  two_pointers_made       NUMERIC,
  two_pointers_attempted  NUMERIC,
  two_pointers_pct        NUMERIC,
  three_pointers_made     NUMERIC,
  three_pointers_attempted NUMERIC,
  three_pointers_pct      NUMERIC,
  free_throws_made        NUMERIC,
  free_throws_attempted   NUMERIC,
  free_throws_pct         NUMERIC,
  offensive_rebounds      NUMERIC,
  defensive_rebounds      NUMERIC,
  rebounds                NUMERIC,
  assists                 NUMERIC,
  steals                  NUMERIC,
  blocked_shots           NUMERIC,
  turnovers               NUMERIC,
  personal_fouls          NUMERIC,
  points                  NUMERIC,
  fantasy_points_fanduel  NUMERIC,
  fantasy_points_draftkings NUMERIC,
  plus_minus              NUMERIC,
  double_doubles          NUMERIC,
  triple_doubles          NUMERIC
);




-- Standings
CREATE TABLE IF NOT EXISTS Standings (
  Season                  INTEGER,
  SeasonType              INTEGER,
  TeamID                  INTEGER,
  Key                     TEXT,
  City                    TEXT,
  Name                    TEXT,
  Conference              TEXT,
  Division                TEXT,
  Wins                    INTEGER,
  Losses                  INTEGER,
  Percentage              NUMERIC,
  ConferenceWins          INTEGER,
  ConferenceLosses        INTEGER,
  DivisionWins            INTEGER,
  DivisionLosses          INTEGER,
  HomeWins                INTEGER,
  HomeLosses              INTEGER,
  AwayWins                INTEGER,
  AwayLosses              INTEGER,
  LastTenWins             INTEGER,
  LastTenLosses           INTEGER,
  PointsPerGameFor        NUMERIC,
  PointsPerGameAgainst    NUMERIC,
  Streak                  INTEGER,
  GamesBack               NUMERIC,
  StreakDescription       TEXT,
  GlobalTeamID            INTEGER,
  ConferenceRank          INTEGER,
  DivisionRank            INTEGER,
  PRIMARY KEY(Season, SeasonType, TeamID),
  FOREIGN KEY(TeamID) REFERENCES Teams(TeamID)
);

-- Games (final)
CREATE TABLE IF NOT EXISTS Games (
  GameID                  INTEGER PRIMARY KEY,
  Season                  INTEGER,
  SeasonType              INTEGER,
  Status                  TEXT,
  Day                     DATE,
  DateTime                TIMESTAMP,
  AwayTeam                TEXT,
  HomeTeam                TEXT,
  AwayTeamId              INTEGER REFERENCES Teams(TeamID),
  HomeTeamID              INTEGER REFERENCES Teams(TeamID),
  StadiumId               INTEGER,
  AwayTeamScore           INTEGER,
  HomeTeamScore           INTEGER,
  PointSpread             NUMERIC,
  OverUnder               NUMERIC,
  AwayTeamMoneyLine       INTEGER,
  HomeTeamMoneyLine       INTEGER,
  HomeRotationNumber      INTEGER,
  AwayRotationNumber      INTEGER,
  NeutralVenue            BOOLEAN,
  Quarters                JSONB
);

-- GamesByDate
CREATE TABLE GamesByDate (
  game_id                 INTEGER PRIMARY KEY,
  season                  INTEGER,
  season_type             INTEGER,
  status                  TEXT,
  day                     DATE,
  date_time               TIMESTAMP,
  away_team               TEXT,
  home_team               TEXT,
  away_team_id            INTEGER,
  home_team_id            INTEGER,
  stadium_id              INTEGER,
  away_team_score         INTEGER,
  home_team_score         INTEGER,
  point_spread            NUMERIC,
  over_under              NUMERIC,
  away_team_money_line    INTEGER,
  home_team_money_line    INTEGER,
  home_rotation_number    INTEGER,
  away_rotation_number    INTEGER,
  neutral_venue           BOOLEAN,
  quarters                JSONB
);



-- Game Odds by Date
CREATE TABLE IF NOT EXISTS GameOddsByDate (
  GameID                 INTEGER REFERENCES Games(GameID),
  DateTime               TIMESTAMP,
  PregameOdds            JSONB,
  PRIMARY KEY(GameID, DateTime)
);

-- Stadiums
CREATE TABLE IF NOT EXISTS Stadiums (
  StadiumID               INTEGER PRIMARY KEY,
  Active                  BOOLEAN,
  Name                    TEXT,
  Address                 TEXT,
  City                    TEXT,
  State                   TEXT,
  Zip                     TEXT,
  Country                 TEXT,
  Capacity                INTEGER,
  GeoLat                  NUMERIC,
  GeoLong                 NUMERIC
);





-- TeamGameStatsByDate
CREATE TABLE TeamGameStatsByDate (
  stat_id                 INTEGER PRIMARY KEY,
  team_id                 INTEGER,
  season_type             INTEGER,
  season                  INTEGER,
  name                    TEXT,
  team                    TEXT,
  wins                    INTEGER,
  losses                  INTEGER,
  game_id                 INTEGER,
  opponent_id             INTEGER,
  opponent                TEXT,
  day                     DATE,
  date_time               TIMESTAMP,
  home_or_away            TEXT,
  games                   INTEGER,
  fantasy_points          NUMERIC,
  minutes                 INTEGER,
  seconds                 INTEGER,
  field_goals_made        NUMERIC,
  field_goals_attempted   NUMERIC,
  field_goals_pct         NUMERIC,
  two_pointers_made       NUMERIC,
  two_pointers_attempted  NUMERIC,
  two_pointers_pct        NUMERIC,
  three_pointers_made     NUMERIC,
  three_pointers_attempted NUMERIC,
  three_pointers_pct      NUMERIC,
  free_throws_made        NUMERIC,
  free_throws_attempted   NUMERIC,
  free_throws_pct         NUMERIC,
  offensive_rebounds      NUMERIC,
  defensive_rebounds      NUMERIC,
  rebounds                NUMERIC,
  assists                 NUMERIC,
  steals                  NUMERIC,
  blocked_shots           NUMERIC,
  turnovers               NUMERIC,
  personal_fouls          NUMERIC,
  points                  NUMERIC,
  fantasy_points_fanduel  NUMERIC,
  fantasy_points_draftkings NUMERIC,
  plus_minus              NUMERIC,
  double_doubles          NUMERIC,
  triple_doubles          NUMERIC
);

-- TeamSeasonStats
CREATE TABLE TeamSeasonStats (
  stat_id                 INTEGER PRIMARY KEY,
  team_id                 INTEGER,
  season_type             INTEGER,
  season                  INTEGER,
  name                    TEXT,
  team                    TEXT,
  wins                    INTEGER,
  losses                  INTEGER,
  games                   INTEGER,
  fantasy_points          NUMERIC,
  minutes                 INTEGER,
  seconds                 INTEGER,
  field_goals_made        NUMERIC,
  field_goals_attempted   NUMERIC,
  field_goals_pct         NUMERIC,
  two_pointers_made       NUMERIC,
  two_pointers_attempted  NUMERIC,
  two_pointers_pct        NUMERIC,
  three_pointers_made     NUMERIC,
  three_pointers_attempted NUMERIC,
  three_pointers_pct      NUMERIC,
  free_throws_made        NUMERIC,
  free_throws_attempted   NUMERIC,
  free_throws_pct         NUMERIC,
  offensive_rebounds      NUMERIC,
  defensive_rebounds      NUMERIC,
  rebounds                NUMERIC,
  assists                 NUMERIC,
  steals                  NUMERIC,
  blocked_shots           NUMERIC,
  turnovers               NUMERIC,
  personal_fouls          NUMERIC,
  points                  NUMERIC,
  fantasy_points_fanduel  NUMERIC,
  fantasy_points_draftkings NUMERIC,
  plus_minus              NUMERIC,
  double_doubles          NUMERIC,
  triple_doubles          NUMERIC
);



-- ============= Bidder Better Schema =============================



-- ========== 1. Membership Levels ==========
CREATE TABLE IF NOT EXISTS membership_levels (
    level_id       SERIAL PRIMARY KEY,
    level_name     VARCHAR(50) NOT NULL,
    max_coins      INT NOT NULL,
    bonus_on_level INT NOT NULL
);

ALTER SEQUENCE membership_levels_level_id_seq MINVALUE 0 RESTART WITH 0;

INSERT INTO membership_levels (level_name, max_coins, bonus_on_level)
VALUES
  ('Bronze',    200,  100), -- level 0
  ('Silver',    500,  100), -- level 1
  ('Gold',      1000, 100), -- level 2
  ('Platinum',  1500, 100)  -- level 3

   ON CONFLICT DO NOTHING;





-- ========== 2. Users ==========
CREATE TABLE IF NOT EXISTS users (
    user_id       SERIAL PRIMARY KEY,
    username      VARCHAR(50) NOT NULL UNIQUE,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    password_hash VARCHAR(255),
    age           INT,
    street_number VARCHAR(10),
    street_name   VARCHAR(100),
    city          VARCHAR(100),
    state         VARCHAR(50),
    zip_code      VARCHAR(10),
    email         VARCHAR(100) UNIQUE,
    phone_number  VARCHAR(20),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_type     VARCHAR(50),
    level_id      INT NOT NULL REFERENCES membership_levels(level_id),
    coin_balance  INT NOT NULL DEFAULT 100
);




-- ========== 3. Coin Transactions ==========
CREATE TABLE IF NOT EXISTS coins (
    coin_id    SERIAL PRIMARY KEY,
    coin_value INT NOT NULL
);

INSERT INTO coins (coin_value) VALUES
  (1),
  (5),
  (10),
  (20),
  (50),
  (100);

CREATE TABLE IF NOT EXISTS coin_limit (
    coin_limit_id SERIAL PRIMARY KEY,
    limit_amount  INT NOT NULL
);


INSERT INTO coin_limit (limit_amount) VALUES
  (200),
  (500),
  (1000),
  (1500);


CREATE TABLE IF NOT EXISTS coin_transactions (
    coin_transaction_id SERIAL PRIMARY KEY,
    user_id             INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    transaction_type    VARCHAR(50) NOT NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS trivia_coins (
    trivia_coin_id SERIAL PRIMARY KEY,
    question_worth INT NOT NULL
);



INSERT INTO trivia_coins (question_worth) VALUES
  (10);
  



-- ========== 4. XP & Leveling ==========
CREATE TABLE IF NOT EXISTS user_xp_level (
    xp_level_id SERIAL PRIMARY KEY,
    xp_level    INT NOT NULL,
    xp_required INT NOT NULL
);


INSERT INTO user_xp_level (xp_level, xp_required) VALUES
  (0,   0),    -- Bronze
  (1, 100),    -- Silver
  (2, 300),    -- Gold
  (3, 600)    -- Platinum (max)
ON CONFLICT DO NOTHING; 


CREATE TABLE IF NOT EXISTS user_xp_total (
    user_id  INT PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    xp_total INT NOT NULL DEFAULT 0
);


CREATE TABLE IF NOT EXISTS xp_activity_log (
    log_id        SERIAL PRIMARY KEY,
    user_id       INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    activity_type VARCHAR(50) NOT NULL,
    xp_change     INT NOT NULL,
    description   TEXT,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS vw_xp_progress_bar (
    xp_progress_bar_id SERIAL PRIMARY KEY,
    xp_range           INT NOT NULL,
    xp_progress        INT NOT NULL,
    progress_diff      INT NOT NULL
);



CREATE TABLE IF NOT EXISTS leaderboard (
    leaderboard_id SERIAL PRIMARY KEY,
    user_id        INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    xp_total       INT NOT NULL,
    rank_position  INT,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS user_profile (
    profile_id SERIAL PRIMARY KEY,
    user_id    INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    image_url  VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS user_rank (
    rank_id   SERIAL PRIMARY KEY,
    user_id   INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    rank_type VARCHAR(50)
);




-- ========== 5. Betting System ==========

-- ------------------------------------------------------------------------------------------ NEW CODE: 
CREATE TABLE bet_types (
  bet_type_id   SERIAL PRIMARY KEY,
  name          VARCHAR(50) UNIQUE NOT NULL  -- e.g. 'moneyline', 'spread', 'parlay'
);

INSERT INTO bet_types (name) VALUES
  ('moneyline'),
  ('spread'),
  ('parlay')
ON CONFLICT DO NOTHING; 



CREATE TABLE xp_awards (
  xp_award_id   SERIAL PRIMARY KEY,
  action        VARCHAR(50) NOT NULL,      -- e.g. 'place', 'win'
  bet_type_id   INT NOT NULL REFERENCES bet_types(bet_type_id),
  xp_amount     INT NOT NULL
);
INSERT INTO xp_awards (action, bet_type_id, xp_amount) VALUES
  ('place',  1, 5),    -- placing a moneyline
  ('win',    1, 10),   -- winning a moneyline
  ('place',  2, 7),    -- placing a spread
  ('win',    2, 15),   -- winning a spread
  ('place',  3, 15),   -- placing a parlay
  ('win',    3, 50)   -- winning a parlay

ON CONFLICT DO NOTHING; 



CREATE TABLE coin_awards (
  coin_award_id SERIAL PRIMARY KEY,
  action        VARCHAR(20) NOT NULL,           -- e.g. 'win'
  bet_type_id   INT     NOT NULL REFERENCES bet_types(bet_type_id),
  coins_awarded INT     NOT NULL,
  multiplier    NUMERIC(5,2) NOT NULL DEFAULT 1
);



INSERT INTO coin_awards (action, bet_type_id, coins_awarded) VALUES
  ('win', 1, 10),    -- moneyline win → 10 coins
  ('win', 2, 15),    -- spread win → 15 coins
  ('win', 3, 50)    -- parlay win → 50 coins

ON CONFLICT DO NOTHING; 

-- ------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS bets (
    bet_id           SERIAL PRIMARY KEY,
    event_id         INT NOT NULL REFERENCES Games(GameID) ON DELETE CASCADE,
    user_id          INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    bet_amount       NUMERIC(10,2) NOT NULL,
    odd_id           INT,
    bet_odd          NUMERIC(10,2) NOT NULL,
    placed_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status           VARCHAR(20) NOT NULL DEFAULT 'active',
    adjustable_until TIMESTAMP,
    cash_out_value   NUMERIC(10,2)
);


CREATE TABLE IF NOT EXISTS bet_transactions (
    bet_transaction_id SERIAL PRIMARY KEY,
    bet_id             INT NOT NULL REFERENCES bets(bet_id) ON DELETE CASCADE,
    amount             NUMERIC(10,2) NOT NULL,
    transaction_type   VARCHAR(50) NOT NULL,
    gateway_txn_id     VARCHAR(255),
    payment_status     VARCHAR(20) NOT NULL DEFAULT 'completed',
    refunded_at        TIMESTAMP,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS winnings (
    winning_id         SERIAL PRIMARY KEY,
    bet_transaction_id INT NOT NULL REFERENCES bet_transactions(bet_transaction_id) ON DELETE CASCADE,
    payout             NUMERIC(10,2) NOT NULL,
    winning_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cash_out           NUMERIC(10,2)
);
CREATE TABLE IF NOT EXISTS bet_statistics (
    stat_id              SERIAL PRIMARY KEY,
    bet_id               INT NOT NULL REFERENCES bets(bet_id) ON DELETE CASCADE,
    user_id              INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    house_edge           NUMERIC(5,2),
    return_percentage    NUMERIC(5,2),
    total_bet_amount     NUMERIC(10,2),
    total_amount_wagered NUMERIC(10,2)
);




-- ========== 6. Raffle System ==========
CREATE SEQUENCE IF NOT EXISTS raffle_ticket_number_seq;

CREATE TABLE IF NOT EXISTS raffle_prizes (
    prize_id     SERIAL PRIMARY KEY,
    prize_number INT NOT NULL,
    prize_type   VARCHAR(50) NOT NULL,
    prize_image_url  VARCHAR(255) -- link to an image asset
);


CREATE TABLE IF NOT EXISTS raffle_events (
    raffle_id        SERIAL PRIMARY KEY,
    prize_id         INT NOT NULL REFERENCES raffle_prizes(prize_id) ON DELETE CASCADE,
    raffle_name      VARCHAR(100) NOT NULL,
    prize_name       VARCHAR(100),
    prize_description TEXT,
    raffle_status    VARCHAR(50),-- open/closed
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    start_time       TIMESTAMP,
    end_time         TIMESTAMP
    -- winning_entry_id INT REFERENCES raffle_entries(raffle_entry_id) ON DELETE SET NULL
);



CREATE TABLE IF NOT EXISTS raffle_entries (
    raffle_entry_id SERIAL PRIMARY KEY,
    raffle_id       INT NOT NULL REFERENCES raffle_events(raffle_id) ON DELETE CASCADE,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    ticket_number   INT NOT NULL DEFAULT nextval('raffle_ticket_number_seq'),
    ticket_price    NUMERIC(10,2) DEFAULT 2,
    entry_status    VARCHAR(20) NOT NULL DEFAULT 'confirmed',
    UNIQUE(raffle_id,user_id),
    UNIQUE(raffle_id,ticket_number)
);


CREATE TABLE IF NOT EXISTS raffle_payments (
    raffle_payment_id SERIAL PRIMARY KEY,
    raffle_id         INT NOT NULL REFERENCES raffle_events(raffle_id) ON DELETE CASCADE,
    user_id           INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    raffle_entry_id   INT NOT NULL REFERENCES raffle_entries(raffle_entry_id) ON DELETE CASCADE,
    ticket_price      NUMERIC(10,2) DEFAULT 2,
    gateway_txn_id    VARCHAR(255),
    payment_status    VARCHAR(20) NOT NULL DEFAULT 'completed',
    refunded_at       TIMESTAMP,
    paid_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


 ALTER TABLE raffle_events
 ADD COLUMN winning_entry_id INT,
  ADD CONSTRAINT fk_raffle_event_winner
   FOREIGN KEY (winning_entry_id)
    REFERENCES raffle_entries(raffle_entry_id)
    ON DELETE SET NULL;
	


-- ========== 7. Trivia System ==========
CREATE TABLE IF NOT EXISTS weekly_trivia_sessions (
    weekly_trivia_id SERIAL PRIMARY KEY,
    session_start    TIMESTAMP NOT NULL,
    session_end      TIMESTAMP NOT NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Create session if not already present
INSERT INTO weekly_trivia_sessions (session_start, session_end)
VALUES
  ('2025-04-27 00:00:00', '2025-05-03 23:59:59'),
  ('2025-05-04 00:00:00', '2025-05-10 23:59:59'),
  ('2025-05-11 00:00:00', '2025-05-17 23:59:59');


CREATE TABLE IF NOT EXISTS trivia_questions (
    trivia_question_id SERIAL PRIMARY KEY,
    weekly_trivia_id   INT NOT NULL REFERENCES weekly_trivia_sessions(weekly_trivia_id) ON DELETE CASCADE,
    question_text      TEXT NOT NULL,
    correct_answer     TEXT NOT NULL
);

INSERT INTO trivia_questions (weekly_trivia_id, question_text, correct_answer) VALUES
  (1, 'Which NBA player holds the all-time regular season scoring record?',                'Kareem Abdul-Jabbar'),
  (1, 'Which team won the first NBA championship in 1947?',                                'Philadelphia Warriors'),
  (1, 'Who is known as "His Airness"?',                                                    'Michael Jordan'),
  (1, 'Which coach has the most NBA championships?',                                       'Phil Jackson'),
  (1, 'What year did the NBA–ABA merger take place?',                                      '1976'),
  (1, 'Which player has the nickname "The Black Mamba"?',                                  'Kobe Bryant'),
  (1, 'Who was the first overall pick in the 2003 NBA Draft?',                             'LeBron James'),
  (1, 'Which team drafted Dirk Nowitzki?',                                                 'Milwaukee Bucks'),
  (1, 'Who is the NBA’s all-time leader in career assists?',                               'John Stockton'),
  (1, 'Which player holds the single–game scoring record with 100 points?',                'Wilt Chamberlain'),


  (2, 'Which city is home to the NBA team known as the Raptors?',                          'Toronto'),
  (2, 'Who won NBA Finals MVP in 2018?',                                                    'Kevin Durant'),
  (2, 'Which player has the most career rebounds?',                                        'Wilt Chamberlain'),
  (2, 'Who hit the famous “Flu Game” performance in the 1997 Finals?',                     'Michael Jordan'),
  (2, 'Which team holds the record for most regular-season wins (73)?',                    'Golden State Warriors'),
  (2, 'Who is the NBA’s all-time leader in career blocks?',                                'Hakeem Olajuwon'),
  (2, 'Which player won Rookie of the Year in 2019–20?',                                   'Ja Morant'),
  (2, 'What year did the three-point line debut in the NBA?',                              '1979'),
  (2, 'Who is the shortest player ever to play in the NBA?',                               'Muggsy Bogues'),
  (2, 'Which NBA team plays at Madison Square Garden?',                                    'New York Knicks'),


  (3, 'Who scored the game-winning shot in Game 6 of the 2013 Finals?',                    'Ray Allen'),
  (3, 'Which player has the most career triple-doubles?',                                  'Russell Westbrook'),
  (3, 'Who was the first European player to win NBA MVP?',                                 'Giannis Antetokounmpo'),
  (3, 'Which Lakers center was nicknamed “The Diesel”?',                                   'Shaquille O’Neal'),
  (3, 'Which team did Shaquille O’Neal win his first championship with?',                  'Los Angeles Lakers'),
  (3, 'Who won the Slam Dunk Contest in 1988 with a free-throw line dunk?',                'Michael Jordan'),
  (3, 'Which player holds the rookie single-game scoring record with 56 points?',          'Devin Booker'),
  (3, 'What is the minimum age to enter the NBA draft?',                                   '19'),
  (3, 'Which NBA commissioner introduced the salary cap?',                                 'David Stern'),
  (3, 'Who was the first player to be unanimously voted MVP?',                             'Stephen Curry');

   
CREATE TABLE IF NOT EXISTS trivia_answers (
    trivia_answer_id   SERIAL PRIMARY KEY,
    user_id            INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    trivia_question_id INT NOT NULL REFERENCES trivia_questions(trivia_question_id) ON DELETE CASCADE,
    user_answer        TEXT,
    answered_correctly BOOLEAN NOT NULL DEFAULT FALSE,
    answered_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS trivia_participants (
    participant_id   SERIAL PRIMARY KEY,
    user_id          INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    weekly_trivia_id INT NOT NULL REFERENCES weekly_trivia_sessions(weekly_trivia_id) ON DELETE CASCADE,
    participated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id,weekly_trivia_id)
);




-- ========== 8. Social Media System ==========
CREATE TABLE IF NOT EXISTS social_posts (
    post_id      SERIAL PRIMARY KEY,
    user_id      INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    content      TEXT,
    image_url    VARCHAR(255),
    betting_slip JSON,
    likes        INT DEFAULT 0,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP
);



CREATE TABLE IF NOT EXISTS post_comments (
    comment_id      SERIAL PRIMARY KEY,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id         INT NOT NULL REFERENCES social_posts(post_id) ON DELETE CASCADE,
    comment_content TEXT NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    word_limit      INT
);



CREATE TABLE IF NOT EXISTS post_like (
    like_id    SERIAL PRIMARY KEY,
    user_id    INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id    INT NOT NULL REFERENCES social_posts(post_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS social_feed (
    feed_id          SERIAL PRIMARY KEY,
    user_id          INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id          INT NOT NULL REFERENCES social_posts(post_id) ON DELETE CASCADE,
    interaction_type VARCHAR(50),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS dms_chat (
    dms_chat_id  SERIAL PRIMARY KEY,
    sender_id    INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    receiver_id  INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    message_text TEXT NOT NULL,
    message_fee  NUMERIC(10,2) DEFAULT 1,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS group_chats (
    group_chat_id SERIAL PRIMARY KEY,
    user_id       INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    chat_name     VARCHAR(100) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    message_limit INT
);




CREATE TABLE IF NOT EXISTS group_chat_members (
    membership_id SERIAL PRIMARY KEY,
    group_chat_id INT NOT NULL REFERENCES group_chats(group_chat_id) ON DELETE CASCADE,
    user_id       INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    has_joined    BOOLEAN DEFAULT FALSE,
    has_paid      BOOLEAN DEFAULT FALSE,
    rank          VARCHAR(50) -- SHOULD rank REFERENCE membership_levels(level_name) 
);




CREATE TABLE IF NOT EXISTS subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    subscriber_id   INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    target_user_id  INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    subscription_fee NUMERIC(10,2) DEFAULT 1,
    subscribed_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(subscriber_id,target_user_id)
);



-- ========== 9. Notifications ==========
CREATE TABLE IF NOT EXISTS notifications (
    notification_id    SERIAL PRIMARY KEY,
    notification_type  VARCHAR(50) NOT NULL,
    message            TEXT NOT NULL,
    sender_id          INT REFERENCES users(user_id) ON DELETE SET NULL,
    related_entity_id  INT,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS user_notifications (
    notification_id INT NOT NULL REFERENCES notifications(notification_id) ON DELETE CASCADE,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    is_read         BOOLEAN NOT NULL DEFAULT FALSE,
    read_at         TIMESTAMP,
    delivered_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(notification_id,user_id)
);




CREATE TABLE IF NOT EXISTS raffle_notifications (
    raffle_notification_id SERIAL PRIMARY KEY,
    user_id                INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    raffle_id              INT NOT NULL REFERENCES raffle_events(raffle_id) ON DELETE CASCADE,
    message                TEXT,
    sent_by                INT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS betting_notifications (
    betting_notification_id SERIAL PRIMARY KEY,
    user_id                 INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    bet_id                  INT NOT NULL REFERENCES bets(bet_id) ON DELETE CASCADE,
    message                 TEXT,
    sent_by                 INT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS social_notifications (
    social_notification_id SERIAL PRIMARY KEY,
    user_id                INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id                INT NOT NULL REFERENCES social_posts(post_id) ON DELETE CASCADE,
    message                TEXT,
    sent_by                INT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS xp_notifications (
    xp_notification_id SERIAL PRIMARY KEY,
    user_id            INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    xp_level_id        INT NOT NULL REFERENCES user_xp_level(xp_level_id) ON DELETE CASCADE,
    message            TEXT,
    sent_by            INT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);





CREATE TABLE IF NOT EXISTS admin_notifications (
    admin_notification_id SERIAL PRIMARY KEY,
    user_id               INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    message               TEXT,
    sent_by               INT REFERENCES users(user_id) ON DELETE SET NULL,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS notification_settings (
    notification_settings_id SERIAL PRIMARY KEY,
    user_id                   INT NOT NULL UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
    web_enabled               BOOLEAN NOT NULL DEFAULT TRUE,
    email_enabled             BOOLEAN NOT NULL DEFAULT TRUE,
    push_enabled              BOOLEAN NOT NULL DEFAULT TRUE,
    created_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




-- ========== 10. Admin Control Tables ==========
CREATE TABLE IF NOT EXISTS system_admin (
    system_admin_id    SERIAL PRIMARY KEY,
    user_id            INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    coin_id            INT REFERENCES coins(coin_id) ON DELETE SET NULL,
    coin_transaction_id INT REFERENCES coin_transactions(coin_transaction_id) ON DELETE SET NULL,
    coin_limit_id      INT REFERENCES coin_limit(coin_limit_id) ON DELETE SET NULL,
    trivia_coin_id     INT REFERENCES trivia_coins(trivia_coin_id) ON DELETE SET NULL,
    xp_level_id        INT REFERENCES user_xp_level(xp_level_id) ON DELETE SET NULL,
    xp_progress_bar_id INT REFERENCES vw_xp_progress_bar(xp_progress_bar_id) ON DELETE SET NULL,
    rank_id            INT REFERENCES user_rank(rank_id) ON DELETE SET NULL,
    notification_id    INT REFERENCES notifications(notification_id) ON DELETE SET NULL
);




CREATE TABLE IF NOT EXISTS betting_admin (
    betting_admin_id   SERIAL PRIMARY KEY,
    user_id            INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    bet_id             INT REFERENCES bets(bet_id) ON DELETE SET NULL,
    bet_transaction_id INT REFERENCES bet_transactions(bet_transaction_id) ON DELETE SET NULL,
    min_wager          NUMERIC(10,2),
    max_wager          NUMERIC(10,2)
);




CREATE TABLE IF NOT EXISTS raffle_admin (
    raffle_admin_id   SERIAL PRIMARY KEY,
    user_id           INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    raffle_id         INT REFERENCES raffle_events(raffle_id) ON DELETE SET NULL,
    raffle_payment_id INT REFERENCES raffle_payments(raffle_payment_id) ON DELETE SET NULL,
    raffle_entry_id   INT REFERENCES raffle_entries(raffle_entry_id) ON DELETE SET NULL,
    prize_id          INT REFERENCES raffle_prizes(prize_id) ON DELETE SET NULL
);




CREATE TABLE IF NOT EXISTS social_admin (
    social_admin_id SERIAL PRIMARY KEY,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id         INT REFERENCES social_posts(post_id) ON DELETE SET NULL,
    comment_id      INT REFERENCES post_comments(comment_id) ON DELETE SET NULL,
    like_id         INT REFERENCES post_like(like_id) ON DELETE SET NULL,
    dms_chat_id     INT REFERENCES dms_chat(dms_chat_id) ON DELETE SET NULL,
    group_chat_id   INT REFERENCES group_chats(group_chat_id) ON DELETE SET NULL,
    membership_id   INT REFERENCES group_chat_members(membership_id) ON DELETE SET NULL
);




-- ========== 11. Disputes & Reports ==========
CREATE TABLE IF NOT EXISTS bet_disputes (
    dispute_id   SERIAL PRIMARY KEY,
    bet_id       INT NOT NULL REFERENCES bets(bet_id) ON DELETE CASCADE,
    user_id      INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    issue        TEXT NOT NULL,
    status       VARCHAR(20) NOT NULL DEFAULT 'open',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at  TIMESTAMP
);




CREATE TABLE IF NOT EXISTS raffle_disputes (
    dispute_id      SERIAL PRIMARY KEY,
    raffle_entry_id INT NOT NULL REFERENCES raffle_entries(raffle_entry_id) ON DELETE CASCADE,
    user_id         INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    issue           TEXT NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'open',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at     TIMESTAMP
);




CREATE TABLE IF NOT EXISTS content_reports (
    report_id   SERIAL PRIMARY KEY,
    reporter_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    post_id     INT REFERENCES social_posts(post_id) ON DELETE CASCADE,
    comment_id  INT REFERENCES post_comments(comment_id) ON DELETE CASCADE,
    reason      TEXT NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'open',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
-- End of BidderBetter Full Schema
-- ==========================================================




INSERT INTO users (username, first_name, last_name, password_hash, age, street_number, street_name, city, state, zip_code, email, phone_number, user_type, level_id, coin_balance) VALUES 

('ADMIN1', 'Reginald', 'Saintil', 'reg_67zeus', 45, '123', 'N Central Ave', 'Phoenix', 'Arizona', '11758', 'reginaldsaintil@outlook.com', '302-555-1843' ,'Social Admin', 3, 1500 ), 

('ADMIN2', 'Dayian', 'Nadeem', 'Day_night3', 35, '514', 'Acorn Drive', 'Pagosa Springs', 'Colorado', '81147', 'dayian.nadeem326@gmail.com', '631-697-6382' ,'Betting Admin', 3, 1500 ), 

('ADMIN3', 'Ryan', 'Varughese', 'rv_trip45', 55, '1173', 'Rock Rimmon Rd', 'Stamford', 'Connecticut', '06903', 'varughese156@gmail.com', '347-859-9640' ,'Raffle Admin', 3, 1500 ), 

('ADMIN4', 'Justice', 'Winslow', 'windows11_jk', 21, '1', 'New Castle St', 'Rehoboth Beach', 'Delaware', '19971', 'reginaldsaintil8@outlook.com', '516-930-5672' ,'System Admin', 3, 1500 ),

('srogers5', 'Sarah', 'Rogers', 'srogers_passwd0', 27, '54', 'Bayview Rd', 'Dover', 'Delaware', '19901', 'srogers5@myyahoo.com', '516-203-6865', 'User', 0, 100),

('dthomas6', 'David', 'Thomas', 'davidT_secure42', 34, '209', 'Maple Ln', 'Wilmington', 'Delaware', '19801', 'davidthomas@bidderbetter.com', '302-882-3391', 'User', 1, 100),
('cmiller7', 'Cassandra', 'Miller', 'cassM!ll2024', 29, '418', 'Cedar St', 'Newark', 'Delaware', '19711', 'cassandramiller@bidderbetter.com', '302-761-4572', 'User', 1, 100),

('zfields5', 'Zaran', 'Fields', 'z09she_is', 19, '5726', 'Macarthur Blvd NW', 'Washington', 'DC', '20016', 'zarfields@bidderbetter.com', '202-361-4073' ,'User', 0, 100 ), 
('kmurphy6', 'Kyla', 'Murphy', 'kmurphy_dc18!', 22, '1834', 'Connecticut Ave NW', 'Washington', 'DC', '20009', 'kylamurphy@bidderbetter.com', '202-845-2194', 'User', 0, 100),
('tramos7', 'Tobias', 'Ramos', 'toR_4life!', 25, '3901', 'Georgia Ave NW', 'Washington', 'DC', '20011', 'tobiasr@bidderbetter.com', '202-332-8819', 'User', 2, 1000),
('anelson8', 'Amira', 'Nelson', 'amiR@nelson22', 20, '201', 'Florida Ave NE', 'Washington', 'DC', '20002', 'amiran@bidderbetter.com', '202-467-0005', 'User', 3, 1100),

('cdiaz6', 'Carmen', 'Diaz', 'disneycars_56', 34, '4803', 'Longwater Way', 'Tampa', 'Florida', '33615', 'carmendiaz@bidderbetter.com', '813-334-8807' , 'User', 0, 100 ), 
('rjohnson7', 'Rafael', 'Johnson', 'rj_florida2024', 29, '1227', 'Orange Blossom Trl', 'Orlando', 'Florida', '32805', 'rafaelj@bidderbetter.com', '407-529-1184', 'User', 0, 100),
('mlopez8', 'Mariana', 'Lopez', 'lopez_M88pass', 42, '7851', 'SW 8th St', 'Miami', 'Florida', '33144', 'marianalopez@bidderbetter.com', '305-411-9022', 'User', 0, 100),
('tkelly9', 'Tristan', 'Kelly', 'tkelly_secure90', 36, '3030', 'Westshore Blvd', 'Tampa', 'Florida', '33629', 'tristank@bidderbetter.com', '813-275-6081', 'User', 0, 100),

('lbelize10', 'Lisa', 'Belize', 'lisa90s_2belize', 24, '10616', 'Happy Trl', 'Woodstock', 'Illinois', '60098', 'lisabelize@bidderbetter.com', '815-260-7618' ,'User', 0, 100 ), 
('jcarter11', 'Jamal', 'Carter', 'jc_secure94!', 31, '4207', 'Prairie Ave', 'Chicago', 'Illinois', '60616', 'jamalcarter@bidderbetter.com', '312-998-4712', 'User', 0, 100),
('anunez12', 'Ariana', 'Nunez', 'nunez_a7life', 28, '1598', 'Elmhurst Rd', 'Elk Grove Village', 'Illinois', '60007', 'ariananunez@bidderbetter.com', '847-673-5428', 'User', 0, 100),
('dmorris13', 'Derek', 'Morris', 'dmorris_il23', 35, '3380', 'Lincoln Hwy', 'Matteson', 'Illinois', '60443', 'derekmorris@bidderbetter.com', '708-219-8804', 'User', 0, 100),

('bmiller14', 'Brandon', 'Miller', 'mrBmills89_', 23, '13797', 'Mill Stream Ct', 'Carmel', 'Indiana', '46032', 'brandonmiller@bidderbetter.com', '' ,'User', 0, 100 ), 
('aroberts15', 'Alicia', 'Roberts', 'alicia_r23in', 26, '5912', 'Meridian St', 'Indianapolis', 'Indiana', '46208', 'aliciaroberts@bidderbetter.com', '317-402-7812', 'User', 0, 100),
('gwhite16', 'Greg', 'White', 'gw_hoosierlife', 30, '2245', 'Wabash Ave', 'Terre Haute', 'Indiana', '47807', 'gregwhite@bidderbetter.com', '812-367-0194', 'User', 0, 100),
('kpatel17', 'Kavya', 'Patel', 'kp_indiapride24', 22, '1443', 'Jackson St', 'Evansville', 'Indiana', '47713', 'kavyapatel@bidderbetter.com', '812-555-8820', 'User', 0, 100),

('cgreco18', 'Cassie', 'Greco', 'Cass_4Gr', 32, '2809', 'Sunset Dr NE', 'Swisher', 'Iowa', '52338', 'cassiegreco@bidderbetter.com', '319-325-8659' ,'User', 0, 100 ), 
('rsmith19', 'Rachel', 'Smith', 'rachS_iowa21', 27, '1124', 'Maplewood Dr', 'Cedar Rapids', 'Iowa', '52403', 'rachelsmith@bidderbetter.com', '319-850-4432','User', 0, 100),
('tbrooks20', 'Tanner', 'Brooks', 'tanB_secure', 35, '3471', 'Main St', 'Dubuque', 'Iowa', '52001', 'tannerbrooks@bidderbetter.com', '563-219-7084', 'User', 0, 100),
('hquinn21', 'Holly', 'Quinn', 'hquinn88!', 29, '772', 'Court St', 'Iowa City', 'Iowa', '52240', 'hollyquinn@bidderbetter.com', '319-672-1190','User', 0, 100),

('sserks22', 'Shannon', 'Serks', 'Raquisha_8', 29, '12860', 'Bradshaw St', 'Overland Park', 'Kansas', '66213', 'shannonserks@bidderbetter.com', '913-221-4028' ,'User', 0, 100),
 
('mwalker23', 'Malik', 'Walker', 'mw_kansas32', 32, '7542', 'Mission Rd', 'Leawood', 'Kansas', '66206', 'malikwalker@bidderbetter.com', '913-475-6831', 'User', 0, 100),
('jyoung24', 'Jasmine', 'Young', 'jyoung_life!', 27, '3315', 'N 54th St', 'Kansas City', 'Kansas', '66104', 'jasmineyoung@bidderbetter.com', '913-620-7290', 'User', 0, 100),
('cphillips25', 'Chris', 'Phillips', 'chrisP_secure', 41, '1093', 'W 85th St', 'Lenexa', 'Kansas', '66219', 'chrisphillips@bidderbetter.com', '913-732-5514','User', 0, 100),

('lneglia26', 'Lindsey', 'Neglia', 'Lindsayy_12x', 37, '1012', 'Windsor Ct', 'Shelbyville', 'Kentucky', '40065', 'lindseyneglia@bidderbetter.com', '502-220-3350' ,'User', 0, 100),
 
('mcasey27', 'Marcus', 'Casey', 'marc_ky88', 22, '4416', 'Ashland Ave', 'Louisville', 'Kentucky', '40215', 'marcuscasey@bidderbetter.com', '502-917-3341', 'User', 0, 100),
('tlowe28', 'Tiana', 'Lowe', 'tlowe!fresh', 30, '2089', 'Meadow Ridge Dr', 'Bowling Green', 'Kentucky', '42101', 'tianalowe@bidderbetter.com', '270-301-4482','User', 0, 100),
('zturner29', 'Zeke', 'Turner', 'zt24_secure', 25, '683', 'Oak Hill Rd', 'Frankfort', 'Kentucky', '40601', 'zeketurner@bidderbetter.com', '502-875-7926', 'User', 0, 100),

('jkender30', 'John', 'Kender', 'JK_jan05bday', 26, '4924', 'Fernwood Dr', 'Lake Charles', 'Louisiana', '70605', 'johnkender@bidderbetter.com', '337-474-2185' ,'User', 0, 100 ), 
('lvernon31', 'Latasha', 'Vernon', 'lvn504_nola', 33, '8182', 'Maple St', 'New Orleans', 'Louisiana', '70118', 'latashavernon@bidderbetter.com', '504-319-7742', 'User', 0, 100),
('dharper32', 'Darnell', 'Harper', 'dharp_lakeview', 29, '6735', 'Pine Hill Dr', 'Baton Rouge', 'Louisiana', '70809', 'darnellharper@bidderbetter.com', '225-730-4168', 'User', 0, 100),
('msimmons33', 'Monique', 'Simmons', 'moSim_88secure', 38, '1240', 'Elmwood St', 'Shreveport', 'Louisiana', '71103', 'moniquesimmons@bidderbetter.com', '318-655-2281','User', 0, 100),

('hmodica33', 'Heather', 'Modica', 'hmodi_fied99', 31, '2', 'Colonel Dow Drive', 'Scarborough', 'Maine', '04074', 'heathermodica@bidderbetter.com', '207-601-2344' ,'User', 0, 100 ), 
('cgrayson34', 'Cory', 'Grayson', 'cg_maine24', 28, '156', 'Ocean Ave', 'Portland', 'Maine', '04103', 'corygrayson@bidderbetter.com', '207-775-1984', 'User', 0, 100),
('lbrooks35', 'Lana', 'Brooks', 'lanab_207x', 35, '872', 'Maple St', 'Bangor', 'Maine', '04401', 'lanabrooks@bidderbetter.com', '207-944-2207', 'User', 0, 100),
('dwells36', 'Devin', 'Wells', 'dw_maineStrong', 26, '490', 'Pine Hill Rd', 'Lewiston', 'Maine', '04240', 'devinwells@bidderbetter.com', '207-376-3102','User', 0, 100),

('apersau37', 'Anjali', 'Persaud', 'app_saudi34', 22, '5030', 'Green Bridge Rd', 'Dayton', 'Maryland', '21036', 'anjalipersuad@bidderbetter.com', '410-913-2400' ,'User', 0, 100 ), 
('jellis38', 'Jared', 'Ellis', 'jellis_mdpass22', 28, '1135', 'Ashford Dr', 'Silver Spring', 'Maryland', '20910', 'jaredellis@bidderbetter.com', '301-526-8912', 'User', 0, 100),
('kgreen39', 'Kendra', 'Green', 'kgreenMD_1999', 34, '7402', 'Cherry Hill Rd', 'College Park', 'Maryland', '20740', 'kendragreen@bidderbetter.com', '240-499-7841', 'User', 0, 100),
('smorris40', 'Seth', 'Morris', 'smorris_bmore!', 25, '8930', 'Harford Rd', 'Baltimore', 'Maryland', '21234', 'sethmorris@bidderbetter.com', '410-324-1089','User', 0, 100),

('scardino41', 'Steven', 'Cardino', 'steve_hoops55', 29, '2', 'Claudette Cir', 'Framingham', 'Massachusetts', '01701', 'stevencardino@bidderbetter.com', '516-203-6865' ,'User', 0, 100 ), 

('jmartin42', 'Jillian', 'Martin', 'jmartin021_bay', 27, '908', 'Beacon St', 'Somerville', 'Massachusetts', '02143', 'jillianmartin@bidderbetter.com', '617-908-7742','User', 0, 100),
('tkennedy43', 'Trevor', 'Kennedy', 'trev_kenboston', 34, '411', 'Elm St', 'Worcester', 'Massachusetts', '01609', 'trevorkennedy@bidderbetter.com', '508-321-9861', 'User', 0, 100),
('cwright44', 'Celine', 'Wright', 'celwright_mass!', 25, '1745', 'Union Ave', 'Lynn', 'Massachusetts', '01901', 'celinewright@bidderbetter.com', '781-653-2290', 'User', 0, 100),

('mrameriz45', 'Manny', 'Rameriz', 'I_AManny2', 43, '73404', 'Castle Ct', 'Armada', 'Michigan', '48005', 'mannyrameriz@bidderbetter.com', '586-541-4000' ,'User', 0, 100), 

('jbowen46', 'Jasmine', 'Bowen', 'jasBowen_mi32', 32, '1954', 'Grand River Ave', 'Detroit', 'Michigan', '48226', 'jasminebowen@bidderbetter.com', '313-702-9184', 'User', 0, 100),
('cpatel47', 'Chirag', 'Patel', 'cp_mich1988!', 28, '6420', 'W Stadium Blvd', 'Ann Arbor', 'Michigan', '48103', 'chiragpatel@bidderbetter.com', '734-210-6672', 'User', 0, 100),
('ksimmons48', 'Kylie', 'Simmons', 'kylieS_rockMI', 36, '899', 'South Drake Rd', 'Kalamazoo', 'Michigan', '49009', 'kyliesimmons@bidderbetter.com', '269-445-3710','User', 0, 100),

('rlane49', 'Ron', 'Lane', 'rizz_90lala', 25, '1006', 'University Pl', 'Reno', 'Nevada', '89512', 'ronlane@bidderbetter.com', '775-354-9255' ,'User', 0, 100),
('kparker50', 'Kiana', 'Parker', 'kp_nevadaVibes', 27, '2431', 'Sierra Vista Dr', 'Las Vegas', 'Nevada', '89169', 'kianaparker@bidderbetter.com', '702-849-1226','User', 0, 100),
('jcollins51', 'Jordan', 'Collins', 'jcoll_westside', 34, '1910', 'W 7th St', 'Reno', 'Nevada', '89503', 'jordancollins@bidderbetter.com', '775-313-4682','User', 0, 100),
('dhoward52', 'Dana', 'Howard', 'danaNV_secure22', 30, '546', 'Desert Inn Rd', 'Henderson', 'Nevada', '89014', 'danahoward@bidderbetter.com', '702-221-9056', 'User', 0, 100),

('dcabey18', 'Dominic', 'Cabey', 'st_doms23hs', 29, '18', 'Brockway Road', 'Hopkinton', 'New Hampshire', '03229', 'dominiccabey@bidderbetter.com', '603-228-1947' ,'User', 0, 100),
 

('aburke53', 'Avery', 'Burke', 'av_burkeNH', 33, '201', 'Maple St', 'Concord', 'New Hampshire', '03301', 'averyburke@bidderbetter.com', '603-715-8842', 'User', 0, 100),
('lwest54', 'Leah', 'West', 'leahwest_92', 26, '484', 'Broadway Ave', 'Manchester', 'New Hampshire', '03101', 'leahwest@bidderbetter.com', '603-441-3307', 'User', 0, 100),
('tknight55', 'Trevor', 'Knight', 'tknight_securenh', 37, '1463', 'River Rd', 'Nashua', 'New Hampshire', '03062', 'trevorknight@bidderbetter.com', '603-231-5784', 'User', 0, 100),

('tcabey56', 'Tracey', 'Cabey', 'tracey_pd21', 65, '6', 'Kristi Dr', 'East Hanover Twp', 'New Jersey', '07936', 'traceycabey@bidderbetter.com', '908-868-3372' ,'User', 0, 100 ), 

('dgrimes57', 'Derek', 'Grimes', 'dgrimes_Jersey88', 41, '222', 'Maple Ave', 'Newark', 'New Jersey', '07102', 'derekgrimes@bidderbetter.com', '973-201-7754', 'User', 0, 100),
('srojas58', 'Sofia', 'Rojas', 'srojas_gardenstate', 29, '890', 'Liberty St', 'Elizabeth', 'New Jersey', '07201', 'sofiarojas@bidderbetter.com', '908-718-2291', 'User', 0, 100),
('cmorgan59', 'Carla', 'Morgan', 'carla_mJz22', 33, '1593', 'West End Ave', 'Trenton', 'New Jersey', '08608', 'carlamorgan@bidderbetter.com', '609-512-4470','User', 0, 100),

('jdieck60', 'Jarred', 'Dieck', 'jdeeks_22', 33, '10', 'Cayuga Lane', 'Irvington', 'New York', '10533', 'jarreddieck@bidderbetter.com', '914-804-8693' ,'User', 0, 100),
('asantiago61', 'Alyssa', 'Santiago', 'alyS_nycity88', 29, '305', 'Amsterdam Ave', 'New York', 'New York', '10023', 'alyssasantiago@bidderbetter.com', '212-603-4529', 'User', 0, 100),
('tmurphy62', 'Tyrell', 'Murphy', 'tmurph_bx24', 36, '774', 'Grand Concourse', 'Bronx', 'New York', '10451', 'tyrellmurphy@bidderbetter.com', '718-298-0033','User', 0, 100),
('nkim63', 'Nari', 'Kim', 'nkim_bklyn2022', 25, '148', 'Nassau Ave', 'Brooklyn', 'New York', '11222', 'narikim@bidderbetter.com', '347-912-6674', 'User', 0, 100),

('gmyers64', 'Grant', 'Myers', 'gm_34nomichael', 25, '4513', 'Touchstone Forest Rd', 'Raleigh', 'North Carolina', '27612', 'grantmyers@bidderbetter.com', '919-230-7847' ,'User', 0, 100),
('alogan65', 'Ariana', 'Logan', 'ari_lognc92', 27, '892', 'Clover Ln', 'Charlotte', 'North Carolina', '28208', 'arianalogan@bidderbetter.com', '704-512-6638','User', 0, 100),
('bwatts66', 'Brent', 'Watts', 'brent_252nc', 33, '614', 'Riverwalk Dr', 'Greenville', 'North Carolina', '27834', 'brentwatts@bidderbetter.com', '252-413-0055','User', 0, 100),
('ktaylor67', 'Kelsey', 'Taylor', 'ktaylor_rdux', 30, '2200', 'Westover Hills Dr', 'Durham', 'North Carolina', '27707', 'kelseytaylor@bidderbetter.com', '984-225-1940', 'User', 0, 100),


('mleithner68', 'Mandie', 'Leithner', 'mountaloysis_21', 28, '14176', 'Fancher Rd', 'Westerville', 'Ohio', '43082', 'mandieleithner@bidderbetter.com', '614-578-4199' ,'User', 0, 100),
('jconner69', 'Jared', 'Conner', 'jc_buckeye88', 35, '2204', 'Worthington Woods Blvd', 'Columbus', 'Ohio', '43085', 'jaredconner@bidderbetter.com', '614-295-1308', 'User', 0, 100),
('slopez70', 'Sabrina', 'Lopez', 'sabrilo_cle24', 26, '703', 'Lorain Ave', 'Cleveland', 'Ohio', '44111', 'sabrinalopez@bidderbetter.com', '216-407-9932', 'User', 0, 100),
('dmartin71', 'Derek', 'Martin', 'dmart_ohgo', 31, '1861', 'Springmill Rd', 'Mansfield', 'Ohio', '44906', 'derekmartin@bidderbetter.com', '419-631-8844', 'User', 0, 100),

('astrange72', 'Ashley', 'Strange', 'pyt_lucki21', 33, '6815', 'NW Concord Dr', 'Corvallis', 'Oregon', '97330', 'ashleystange@bidderbetter.com', '541-760-6858' ,'User', 0, 100),
('cjones73', 'Courtney', 'Jones', 'cj_oregontrail', 27, '2190', 'E Burnside St', 'Portland', 'Oregon', '97214', 'courtneyjones@bidderbetter.com', '503-894-2210', 'User', 0, 100),
('rvasquez74', 'Rico', 'Vasquez', 'ricoV_eugene', 38, '1337', 'Lincoln St', 'Eugene', 'Oregon', '97401', 'ricovasquez@bidderbetter.com', '541-346-7792', 'User', 0, 100),
('nmoore75', 'Nina', 'Moore', 'nina_PDX99', 29, '760', 'Liberty St SE', 'Salem', 'Oregon', '97301', 'ninamoore@bidderbetter.com', '503-588-1208','User', 0, 100),

('jscuderi23', 'Joey', 'Scuderi', 'bestfriend_22la', 67, '1215', 'Georgetown Cir', 'Carlisle', 'Pennsylvania', '17013', 'joeyscuderi@bidderbetter.com', '717-574-0425' ,'User', 0, 100),
('kburke76', 'Kendra', 'Burke', 'kendyb_215x', 31, '804', 'Chestnut St', 'Philadelphia', 'Pennsylvania', '19107', 'kendraburke@bidderbetter.com', '215-872-9943', 'User', 0, 100),
('rmorris77', 'Rodney', 'Morris', 'rmor_pittpass', 38, '1132', 'Liberty Ave', 'Pittsburgh', 'Pennsylvania', '15222', 'rodneymorris@bidderbetter.com', '412-299-3788', 'User', 0, 100),
('ajenkins78', 'Alyssa', 'Jenkins', 'alyjen_HBG27', 26, '943', 'Market St', 'Harrisburg', 'Pennsylvania', '17101', 'alyssajenkins@bidderbetter.com', '717-310-5416', 'User', 0, 100),

('zsaldana79', 'Zoey', 'Saldana', 'missmarvel89_', 49, '26', 'Shale Ridge Ct', 'Cumberland', 'Rhode Island', '02864', 'zoeysaldana@bidderbetter.com', '401-787-7128' ,'User', 0, 100),
('mcarter80', 'Miles', 'Carter', 'miles_rilife21', 36, '118', 'Benefit St', 'Providence', 'Rhode Island', '02903', 'milescarter@bidderbetter.com', '401-921-3387', 'User', 0, 100),
('lramirez81', 'Lana', 'Ramirez', 'lanaRI_804', 28, '746', 'Warwick Ave', 'Warwick', 'Rhode Island', '02888', 'lanaramirez@bidderbetter.com', '401-748-6220', 'User', 0, 100),
('thoward82', 'Tobias', 'Howard', 'thow_riSecure', 42, '339', 'Newport Ave', 'Pawtucket', 'Rhode Island', '02861', 'tobiashoward@bidderbetter.com', '401-543-9172', 'User', 0, 100),

('vgood83', 'Victoria', 'Good', 'veryGood_39', 45, '3310', 'Bridgewater Xing', 'Maryville', 'Tennessee', '37804', 'victoriagood@bidderbetter.com', '843-424-7149' ,'User', 0, 100),
('mking84', 'Marcus', 'King', 'mk_tennpass21', 37, '7481', 'Old Hickory Blvd', 'Nashville', 'Tennessee', '37209', 'marcusking@bidderbetter.com', '615-842-1103', 'User', 0, 100),
('lwaters85', 'Lena', 'Waters', 'lwat_mtown88', 29, '580', 'Union Ave', 'Memphis', 'Tennessee', '38103', 'lenawaters@bidderbetter.com', '901-312-6671','User', 0, 100),
('tjames86', 'Terrence', 'James', 'tj_rockytop99', 34, '921', 'Volunteer Dr', 'Knoxville', 'Tennessee', '37932', 'terrencejames@bidderbetter.com', '865-229-4874', 'User', 0, 100),

('kcherry87', 'Kirby', 'Cherry', 'missyou_bro78', 30, '78', 'Penny Brook Road', 'Randolph', 'Vermont', '05060', 'kirbycherry@bidderbetter.com', '802-728-9800' ,'User', 0, 100),
('jfreeman88', 'Jade', 'Freeman', 'jadeVT_89', 22, '114', 'Main St', 'Barre', 'Vermont', '05641', 'jadefreeman@bidderbetter.com', '802-476-2084', 'User', 0, 100),
('bcarson89', 'Brett', 'Carson', 'bcar_greenmtns', 31, '667', 'Maple Ave', 'Rutland', 'Vermont', '05701', 'brettcarson@bidderbetter.com', '802-775-9321', 'User', 0, 100),
('mmorris90', 'Melanie', 'Morris', 'melmor88vt', 26, '330', 'North Ave', 'Burlington', 'Vermont', '05401', 'melaniemorris@bidderbetter.com', '802-658-1107', 'User', 0, 100),

('jcherry27', 'Jordan', 'Cherry', 'Hopeyourokay_09', 38, '2617', 'Bombay Lndg', 'Virginia Beach', 'Virginia', '23456', 'jordancherry@bidderbetter.com', '757-843-9000' ,'User', 0, 100),
('tsimmons91', 'Tiana', 'Simmons', 'tiana_va22', 31, '1148', 'Franklin Rd SW', 'Roanoke', 'Virginia', '24016', 'tianasimmons@bidderbetter.com', '540-283-9971', 'User', 0, 100),
('dmanning92', 'Drew', 'Manning', 'dman757_secure', 35, '337', 'Hampton Hwy', 'Hampton', 'Virginia', '23669', 'drewmanning@bidderbetter.com', '757-620-4405', 'User', 0, 100),
('kwood93', 'Kaitlyn', 'Wood', 'kw_richmondlife', 27, '2921', 'Monument Ave', 'Richmond', 'Virginia', '23221', 'kaitlynwood@bidderbetter.com', '804-311-8820','User', 0, 100),

('kbryan28', 'Koby', 'Bryan', 'blackMAMBA24_', 50, '3723', '36th Loop NW', 'Olympia', 'Washington', '98502', 'kobybryan@bidderbetter.com', '360-712-3244' ,'User', 0, 100), 
('asanders94', 'Alyssa', 'Sanders', 'aly_pnwVibes21', 34, '1421', 'Broadway Ave', 'Seattle', 'Washington', '98122', 'alyssasanders@bidderbetter.com', '206-441-8876','User', 0, 100),
('tjames95', 'Troy', 'James', 'troy_spokaneWA', 28, '899', 'Sprague Ave', 'Spokane', 'Washington', '99201', 'troyjames@bidderbetter.com', '509-328-1102','User', 0, 100),
('cmorris96', 'Claire', 'Morris', 'claire_mtRainier88', 39, '412', '6th Ave SE', 'Puyallup', 'Washington', '98372', 'clairemorris@bidderbetter.com', '253-846-7773','User', 0, 100),

('ljames97', 'Lesly', 'James', 'lele_J45s', 36, '751', 'Mount Levels Farms Rd', 'Paw Paw', 'West Virginia', '25434', 'leslyjames@bidderbetter.com', '540-683-1100' ,'User', 0, 100),

('bclark98', 'Brandon', 'Clark', 'bc_wvrock88', 41, '3920', 'Elk River Rd', 'Charleston', 'West Virginia', '25302', 'brandonclark@bidderbetter.com', '304-932-4450', 'User', 0, 100),
('nmason99', 'Natalie', 'Mason', 'natm_blueWV27', 28, '128', 'College Ave', 'Morgantown', 'West Virginia', '26505', 'nataliemason@bidderbetter.com', '304-291-1123','User', 0, 100),
('zward100', 'Zeke', 'Ward', 'zward_appalachia', 35, '665', 'Maple St', 'Martinsburg', 'West Virginia', '25401', 'zekeward@bidderbetter.com', '304-676-8932','User', 0, 100),


('mbrown30', 'Mason', 'Brown', 'brownie_90mas', 62, '5922', 'Heathermoor Lane', 'Eau Claire', 'Wisconsin', '54703', 'masonbrown@bidderbetter.com', '262-893-6049' ,'User', 0, 100),
('jthomas101', 'Jillian', 'Thomas', 'jillWI_22cool', 24, '830', 'Milwaukee St', 'Madison', 'Wisconsin', '53703', 'jillianthomas@bidderbetter.com', '608-210-3398', 'User', 0, 100),
('rkelly102', 'Raymond', 'Kelly', 'ray_mke89', 45, '1147', 'North Ave', 'Milwaukee', 'Wisconsin', '53212', 'raymondkelly@bidderbetter.com', '414-920-4850', 'User', 0, 100),
('swhite103', 'Sierra', 'White', 'siwi_greenbay', 27, '523', 'Main St', 'Green Bay', 'Wisconsin', '54301', 'sierrawhite@bidderbetter.com', '920-435-7832', 'User', 0, 100),


('lclarke104', 'Laurie', 'Clarke', 'hey_itLaurie22', 35, '3206', 'Smith Pl', 'Cheyenne', 'Wyoming', '82009', 'clarkent_66', '516-203-6865' , 'User', 0, 100),
('jford105', 'Jackson', 'Ford', 'jax_rockyWY', 22, '117', 'Capitol Ave', 'Cheyenne', 'Wyoming', '82001', 'jacksonford@bidderbetter.com', '307-214-9902', 'User', 0, 100),
('emoss106', 'Emily', 'Moss', 'em_wywind22', 28, '8743', 'Ridge Rd', 'Laramie', 'Wyoming', '82070', 'emilymoss@bidderbetter.com', '307-745-2811', 'User', 0, 100),
('bdavis107', 'Bryce', 'Davis', 'bryceWYopen', 31, '502', 'Big Horn Ave', 'Cody', 'Wyoming', '82414', 'brycedavis@bidderbetter.com', '307-587-9940', 'User', 0, 100);


INSERT INTO Standings (
  Season, SeasonType, TeamID, Key, City, Name, Conference, Division,
  Wins, Losses, Percentage, ConferenceWins, ConferenceLosses, DivisionWins,
  DivisionLosses, HomeWins, HomeLosses, AwayWins, AwayLosses,
  LastTenWins, LastTenLosses, PointsPerGameFor, PointsPerGameAgainst,
  Streak, GamesBack, StreakDescription, GlobalTeamID, ConferenceRank, DivisionRank
) VALUES
(2025, 1,  9, 'BOS', 'Boston',     'Celtics',     'Eastern',   'Atlantic',    61, 21, 0.744, 39, 13, 14,  2, 28, 13, 33,  8,  8,  2, 116.26, 107.15,  2,  3.00, 'W2', 20000009,  2, 1),
(2025, 1,  6, 'NY',  'New York',   'Knicks',      'Eastern',   'Atlantic',    51, 31, 0.622, 34, 18, 12,  4, 27, 14, 24, 17,  6,  4, 115.78, 111.68,  1, 13.00, 'W1', 20000006,  3, 2),
(2025, 1, 10, 'TOR', 'Toronto',    'Raptors',     'Eastern',   'Atlantic',    30, 52, 0.366, 21, 31,  8,  8, 18, 23, 12, 29,  5,  5, 110.86, 115.15, -2, 34.00, 'L2', 20000010, 11, 3),
(2025, 1,  8, 'BKN', 'Brooklyn',   'Nets',        'Eastern',   'Atlantic',    26, 56, 0.317, 14, 37,  3, 13, 12, 29, 14, 27,  3,  7, 105.10, 112.21, -3, 38.00, 'L3', 20000008, 12, 4),
(2025, 1,  7, 'PHI', 'Philadelphia','76ers',       'Eastern',   'Atlantic',    24, 58, 0.293, 15, 37,  3, 13, 12, 29, 12, 29,  1,  9, 109.60, 115.84, -2, 40.00, 'L2', 20000007, 13, 5),
(2025, 1, 12, 'CLE', 'Cleveland',  'Cavaliers',   'Eastern',   'Central',     64, 18, 0.780, 41, 11, 12,  4, 34,  7, 30, 11,  6,  4, 121.93, 112.40, -1,  0.00, 'L1', 20000012,  1, 1),
(2025, 1, 13, 'IND', 'Indiana',    'Pacers',      'Eastern',   'Central',     50, 32, 0.610, 29, 22, 10,  6, 29, 12, 21, 20,  8,  2, 117.36, 115.13,  1, 14.00, 'W1', 20000013,  4, 2),
(2025, 1, 15, 'MIL', 'Milwaukee',  'Bucks',       'Eastern',   'Central',     48, 34, 0.585, 31, 21,  9,  7, 28, 14, 20, 20,  8,  2, 115.51, 113.03,  8, 16.00, 'W8', 20000015,  5, 3),
(2025, 1, 14, 'DET', 'Detroit',    'Pistons',     'Eastern',   'Central',     44, 38, 0.537, 29, 23,  5, 11, 22, 19, 22, 19,  4,  6, 115.50, 113.59, -2, 20.00, 'L2', 20000014,  6, 4),
(2025, 1, 11, 'CHI', 'Chicago',    'Bulls',       'Eastern',   'Central',     39, 43, 0.476, 28, 24,  4, 12, 18, 23, 21, 20,  7,  3, 117.80, 119.36,  3, 25.00, 'W3', 20000011, 10, 5),
(2025, 1,  5, 'ORL', 'Orlando',    'Magic',       'Eastern',   'Southeast',   41, 41, 0.500, 31, 21, 12,  4, 22, 19, 19, 22,  7,  3, 105.42, 105.54, -1, 23.00, 'L1', 20000005,  7, 1),
(2025, 1,  3, 'ATL', 'Atlanta',    'Hawks',       'Eastern',   'Southeast',   40, 42, 0.488, 30, 22, 10,  6, 21, 19, 19, 23,  5,  5, 118.18, 119.31,  3, 24.00, 'W3', 20000003,  9, 3),
(2025, 1,  4, 'MIA', 'Miami',      'Heat',        'Eastern',   'Southeast',   37, 45, 0.451, 24, 28, 10,  6, 19, 22, 18, 23,  6,  4, 110.59, 110.03, -1, 27.00, 'L1', 20000004,  8, 2),
(2025, 1,  2, 'CHA', 'Charlotte',  'Hornets',     'Eastern',   'Southeast',   19, 63, 0.232, 10, 42,  1, 15, 12, 29,  7, 34,  1,  9, 105.09, 114.20, -7, 45.00, 'L7', 20000002, 14, 4),
(2025, 1,  1, 'WAS', 'Washington', 'Wizards',     'Eastern',   'Southeast',   18, 64, 0.220, 13, 39,  7,  9,  8, 33, 10, 31,  2,  8, 108.00, 120.43,  1, 46.00, 'W1', 20000001, 15, 5),
(2025, 1, 18, 'OKC', 'Oklahoma City','Thunder',   'Western',   'Northwest',   68, 14, 0.829, 39, 13, 12,  4, 36,  6, 32,  8,  8,  2, 120.50, 107.63,  4,  0.00, 'W4', 20000018,  1, 1),
(2025, 1, 20, 'DEN', 'Denver',     'Nuggets',     'Western',   'Northwest',   50, 32, 0.610, 32, 20,  8,  8, 26, 15, 24, 17,  5,  5, 120.75, 116.86,  3, 18.00, 'W3', 20000020,  4, 2),
(2025, 1, 16, 'MIN', 'Minnesota',  'Timberwolves','Western', 'Northwest',   49, 33, 0.598, 33, 19, 11,  5, 25, 16, 24, 17,  8,  2, 114.29, 109.29,  3, 19.00, 'W3', 20000016,  6, 3),
(2025, 1, 19, 'POR', 'Portland',   'Trail Blazers','Western','Northwest',   36, 46, 0.439, 19, 33,  6, 10, 22, 19, 14, 27,  4,  6, 110.89, 113.86,  1, 32.00, 'W1', 20000019, 12, 4),
(2025, 1, 17, 'UTA', 'Utah',       'Jazz',        'Western',   'Northwest',   17, 65, 0.207,  8, 44,  3, 13, 10, 31,  7, 34,  1,  9, 111.89, 121.23, -2, 51.00, 'L2', 20000017, 15, 5),
(2025, 1, 27, 'LAL', 'Los Angeles','Lakers',      'Western',   'Pacific',     50, 32, 0.610, 36, 16, 12,  4, 31, 10, 19, 22,  6,  4, 113.39, 112.17, -1, 18.00, 'L1', 20000027,  3, 1),
(2025, 1, 28, 'LAC', 'Los Angeles','Clippers',    'Western',   'Pacific',     50, 32, 0.610, 29, 23,  9,  7, 30, 11, 20, 21,  9,  1, 112.87, 108.21,  8, 18.00, 'W8', 20000028,  5, 2),
(2025, 1, 26, 'GS',  'Golden State','Warriors',    'Western',   'Pacific',     48, 34, 0.585, 29, 23,  5, 11, 24, 17, 24, 17,  7,  3, 113.79, 110.48, -1, 20.00, 'L1', 20000026,  7, 3),
(2025, 1, 30, 'SAC','Sacramento',  'Kings',       'Western',   'Pacific',     40, 42, 0.488, 26, 26,  5, 11, 20, 21, 20, 21,  5,  5, 115.73, 115.25,  1, 28.00, 'W1', 20000030,  9, 4),
(2025, 1, 29, 'PHO','Phoenix',     'Suns',        'Western',   'Pacific',     36, 46, 0.439, 22, 30,  9,  7, 24, 17, 12, 29,  1,  9, 113.62, 116.62, -1, 32.00, 'L1', 20000029, 11, 5),
(2025, 1, 22, 'HOU','Houston',     'Rockets',     'Western',   'Southwest',   52, 30, 0.634, 31, 21, 13,  3, 29, 12, 23, 18,  6,  4, 114.29, 109.78, -3, 16.00, 'L3', 20000022,  2, 1),
(2025, 1, 21, 'MEM','Memphis',     'Grizzlies',   'Western',   'Southwest',   48, 34, 0.585, 27, 24, 11,  5, 26, 15, 22, 19,  4,  6, 121.70, 116.85,  1, 20.00, 'W1', 20000021,  8, 2),
(2025, 1, 25, 'DAL','Dallas',      'Mavericks',   'Western',   'Southwest',   39, 43, 0.476, 23, 29,  8,  8, 22, 18, 17, 25,  4,  6, 114.19, 115.39, -1, 29.00, 'L1', 20000025, 10, 3),
(2025, 1, 24, 'SA', 'San Antonio','Spurs',       'Western',   'Southwest',   34, 48, 0.415, 22, 30,  5, 11, 20, 21, 14, 27,  3,  7, 113.92, 116.68,  1, 34.00, 'W1', 20000024, 13, 4),
(2025, 1, 23, 'NO', 'New Orleans','Pelicans',    'Western',   'Southwest',   21, 61, 0.256, 13, 38,  3, 13, 14, 27,  7, 34,  2,  8, 109.82, 119.25, -7, 47.00, 'L7', 20000023, 14, 5);


SELECT * FROM users; -- good

SELECT * FROM users ORDER BY user_id DESC;


SELECT * FROM trivia_questions; -- good

SELECT * FROM weekly_trivia_sessions; -- good 

SELECT * FROM coins; -- good

SELECT * FROM coin_limit; -- good

SELECT * FROM coin_awards; -- good

SELECT * FROM user_xp_level; -- good

SELECT * FROM bet_types; -- good

SELECT * FROM xp_awards; -- goood

SELECT * FROM Players; -- good

SELECT * FROM PlayerGameStatsByDate; -- bad / FIXED = good

SELECT * FROM PlayerSeasonStats; -- bad /FIXED = good

SELECT * FROM Standings; -- bad / not really needed / FIXED BUT HARD CODED - PARENT API DENIED ACCESS = good 

SELECT * FROM Teams; -- good

SELECT * FROM TeamGameStatsByDate; -- bad / FIXED = good

SELECT * FROM CurrentSeason; -- good

SELECT * FROM Stadiums; -- good

SELECT * FROM Games; -- good

SELECT * FROM GameOddsByDate; -- good

SELECT * FROM GamesByDate; -- good

SELECT usename FROM pg_user;


SELECT inet_server_addr(), current_database(), current_user;

SELECT inet_client_addr() AS your_ip;



-- DROP SCHEMA public CASCADE;
-- CREATE SCHEMA public;


SELECT COUNT(*) 
FROM information_schema.tables 
WHERE table_schema = 'public';