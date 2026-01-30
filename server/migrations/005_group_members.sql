CREATE TABLE group_members(
	group_id UUID REFERENCES groups(id) ON DELETE CASCADE,
	user_id UUID REFERENCES users(id) ON DELETE CASCADE,
	role TEXT NOT NULL DEFAULT 'member',
	joined_at TIMESTAMP NOT NULL DEFAULT NOW()
	PRIMARY KEY (group_id, user_id)
);