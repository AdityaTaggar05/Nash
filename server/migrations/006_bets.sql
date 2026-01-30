CREATE TABLE bets(
	id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
	group_id UUID REFERENCES groups(id) ON DELETE CASCADE,
	creator_id UUID REFERENCES users(id),
	title TEXT NOT NULL,
	total_pot NUMERIC NOT NULL DEFAULT 0,
	status TEXT NOT NULL DEFAULT 'open',
	winning_option TEXT,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	expires_at TIMESTAMP NOT NULL,
);

CREATE INDEX group_bets_idx ON bets (group_id);