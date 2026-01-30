CREATE TABLE user_bets(
	bet_id UUID REFERENCES bets(id) ON DELETE CASCADE,
	user_id UUID REFERENCES users(id) ON DELETE CASCADE,
	amount NUMERIC NOT NULL,
	selected_option TEXT NOT NULL,
	status TEXT NOT NULL DEFAULT 'active',
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	PRIMARY KEY (bet_id, user_id)
);