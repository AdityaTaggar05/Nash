CREATE TABLE transactions(
	id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
	bet_id UUID REFERENCES bets(id),
	user_id UUID NOT NULL REFERENCES users(id),
	amount NUMERIC NOT NULL,
	description TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX bet_transactions_idx ON transactions(bet_id);
CREATE INDEX user_transactions_idx ON transactions(user_id);