CREATE TABLE `game_tiebreaker_item_participants` (
	`game_item_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	PRIMARY KEY(`game_item_id`, `player_id`),
	FOREIGN KEY (`game_item_id`) REFERENCES `game_items`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `game_winners` (
	`game_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	PRIMARY KEY(`game_id`, `player_id`),
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
