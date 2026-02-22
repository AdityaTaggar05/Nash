CREATE TABLE messages(
	id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
	sender_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  username TEXT NOT NULL REFERENCES users(username) ON DELETE CASCADE,
	bet_id UUID NOT NULL REFERENCES bets(id) ON DELETE CASCADE,
	content TEXT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX bet_messages_idx ON messages(bet_id);
