PRAGMA foreign_keys=OFF;--> statement-breakpoint
CREATE TABLE `__new_game_game_types` (
	`game_id` integer NOT NULL,
	`game_type_id` integer NOT NULL,
	PRIMARY KEY(`game_id`, `game_type_id`),
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`game_type_id`) REFERENCES `game_types`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_game_types`("game_id", "game_type_id") SELECT "game_id", "game_type_id" FROM `game_game_types`;--> statement-breakpoint
DROP TABLE `game_game_types`;--> statement-breakpoint
ALTER TABLE `__new_game_game_types` RENAME TO `game_game_types`;--> statement-breakpoint
PRAGMA foreign_keys=ON;--> statement-breakpoint
CREATE TABLE `__new_game_item_clues` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_item_id` integer NOT NULL,
	`clue_number` integer NOT NULL,
	`clue` text NOT NULL,
	`is_completed` integer DEFAULT false NOT NULL,
	FOREIGN KEY (`game_item_id`) REFERENCES `game_items`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
INSERT INTO `__new_game_item_clues`("id", "game_item_id", "clue_number", "clue", "is_completed") SELECT "id", "game_item_id", "clue_number", "clue", "is_completed" FROM `game_item_clues`;--> statement-breakpoint
DROP TABLE `game_item_clues`;--> statement-breakpoint
ALTER TABLE `__new_game_item_clues` RENAME TO `game_item_clues`;--> statement-breakpoint
CREATE UNIQUE INDEX `game_item_clues_game_item_id_clue_number_unique` ON `game_item_clues` (`game_item_id`,`clue_number`);--> statement-breakpoint
CREATE TABLE `__new_game_item_guesses` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_item_id` integer NOT NULL,
	`game_item_clue_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	`guess` text,
	`clue_heard` text,
	`is_correct` integer DEFAULT false NOT NULL,
	FOREIGN KEY (`game_item_id`) REFERENCES `game_items`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`game_item_clue_id`) REFERENCES `game_item_clues`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_item_guesses`("id", "game_item_id", "game_item_clue_id", "player_id", "guess", "clue_heard", "is_correct") SELECT "id", "game_item_id", "game_item_clue_id", "player_id", "guess", "clue_heard", "is_correct" FROM `game_item_guesses`;--> statement-breakpoint
DROP TABLE `game_item_guesses`;--> statement-breakpoint
ALTER TABLE `__new_game_item_guesses` RENAME TO `game_item_guesses`;--> statement-breakpoint
CREATE UNIQUE INDEX `game_item_guesses_game_item_id_player_id_unique` ON `game_item_guesses` (`game_item_id`,`player_id`);--> statement-breakpoint
CREATE TABLE `__new_game_items` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_id` integer NOT NULL,
	`item_number` integer NOT NULL,
	`round_number` integer,
	`game_item_type_id` integer NOT NULL,
	`item_answer` text NOT NULL,
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`game_item_type_id`) REFERENCES `game_item_types`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_items`("id", "game_id", "item_number", "round_number", "game_item_type_id", "item_answer") SELECT "id", "game_id", "item_number", "round_number", "game_item_type_id", "item_answer" FROM `game_items`;--> statement-breakpoint
DROP TABLE `game_items`;--> statement-breakpoint
ALTER TABLE `__new_game_items` RENAME TO `game_items`;--> statement-breakpoint
CREATE UNIQUE INDEX `game_items_game_id_item_number_unique` ON `game_items` (`game_id`,`item_number`);--> statement-breakpoint
CREATE TABLE `__new_game_player_sponsors` (
	`game_id` integer NOT NULL,
	`sponsor_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	PRIMARY KEY(`game_id`, `sponsor_id`, `player_id`),
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`sponsor_id`) REFERENCES `sponsors`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_player_sponsors`("game_id", "sponsor_id", "player_id") SELECT "game_id", "sponsor_id", "player_id" FROM `game_player_sponsors`;--> statement-breakpoint
DROP TABLE `game_player_sponsors`;--> statement-breakpoint
ALTER TABLE `__new_game_player_sponsors` RENAME TO `game_player_sponsors`;--> statement-breakpoint
CREATE TABLE `__new_game_players` (
	`game_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	PRIMARY KEY(`game_id`, `player_id`),
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_players`("game_id", "player_id") SELECT "game_id", "player_id" FROM `game_players`;--> statement-breakpoint
DROP TABLE `game_players`;--> statement-breakpoint
ALTER TABLE `__new_game_players` RENAME TO `game_players`;--> statement-breakpoint
CREATE TABLE `__new_game_prizes` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_id` integer NOT NULL,
	`prize` text NOT NULL,
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
INSERT INTO `__new_game_prizes`("id", "game_id", "prize") SELECT "id", "game_id", "prize" FROM `game_prizes`;--> statement-breakpoint
DROP TABLE `game_prizes`;--> statement-breakpoint
ALTER TABLE `__new_game_prizes` RENAME TO `game_prizes`;--> statement-breakpoint
CREATE TABLE `__new_game_rounds` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_id` integer NOT NULL,
	`round_number` integer NOT NULL,
	`initial_combination_id` integer NOT NULL,
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`initial_combination_id`) REFERENCES `initial_combinations`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_rounds`("id", "game_id", "round_number", "initial_combination_id") SELECT "id", "game_id", "round_number", "initial_combination_id" FROM `game_rounds`;--> statement-breakpoint
DROP TABLE `game_rounds`;--> statement-breakpoint
ALTER TABLE `__new_game_rounds` RENAME TO `game_rounds`;--> statement-breakpoint
CREATE UNIQUE INDEX `game_rounds_game_id_round_number_unique` ON `game_rounds` (`game_id`,`round_number`);--> statement-breakpoint
CREATE TABLE `__new_game_sponsors` (
	`game_id` integer NOT NULL,
	`sponsor_id` integer NOT NULL,
	PRIMARY KEY(`game_id`, `sponsor_id`),
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`sponsor_id`) REFERENCES `sponsors`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_sponsors`("game_id", "sponsor_id") SELECT "game_id", "sponsor_id" FROM `game_sponsors`;--> statement-breakpoint
DROP TABLE `game_sponsors`;--> statement-breakpoint
ALTER TABLE `__new_game_sponsors` RENAME TO `game_sponsors`;--> statement-breakpoint
CREATE TABLE `__new_game_tiebreaker_item_participants` (
	`game_item_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	PRIMARY KEY(`game_item_id`, `player_id`),
	FOREIGN KEY (`game_item_id`) REFERENCES `game_items`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_tiebreaker_item_participants`("game_item_id", "player_id") SELECT "game_item_id", "player_id" FROM `game_tiebreaker_item_participants`;--> statement-breakpoint
DROP TABLE `game_tiebreaker_item_participants`;--> statement-breakpoint
ALTER TABLE `__new_game_tiebreaker_item_participants` RENAME TO `game_tiebreaker_item_participants`;--> statement-breakpoint
CREATE TABLE `__new_game_winners` (
	`game_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	PRIMARY KEY(`game_id`, `player_id`),
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_game_winners`("game_id", "player_id") SELECT "game_id", "player_id" FROM `game_winners`;--> statement-breakpoint
DROP TABLE `game_winners`;--> statement-breakpoint
ALTER TABLE `__new_game_winners` RENAME TO `game_winners`;--> statement-breakpoint
CREATE TABLE `__new_jackpots` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_id` integer NOT NULL,
	`one_correct` integer NOT NULL,
	`both_correct` integer NOT NULL,
	`caller_name` text,
	`caller_guess_initials_combination_id` integer,
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`caller_guess_initials_combination_id`) REFERENCES `initial_combinations`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_jackpots`("id", "game_id", "one_correct", "both_correct", "caller_name", "caller_guess_initials_combination_id") SELECT "id", "game_id", "one_correct", "both_correct", "caller_name", "caller_guess_initials_combination_id" FROM `jackpots`;--> statement-breakpoint
DROP TABLE `jackpots`;--> statement-breakpoint
ALTER TABLE `__new_jackpots` RENAME TO `jackpots`;--> statement-breakpoint
CREATE TABLE `__new_player_prize_beneficiaries` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_prize_id` integer NOT NULL,
	`player_id` integer NOT NULL,
	`pick_order` integer NOT NULL,
	`beneficiary_name` text NOT NULL,
	FOREIGN KEY (`game_prize_id`) REFERENCES `game_prizes`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`player_id`) REFERENCES `participants`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
INSERT INTO `__new_player_prize_beneficiaries`("id", "game_prize_id", "player_id", "pick_order", "beneficiary_name") SELECT "id", "game_prize_id", "player_id", "pick_order", "beneficiary_name" FROM `player_prize_beneficiaries`;--> statement-breakpoint
DROP TABLE `player_prize_beneficiaries`;--> statement-breakpoint
ALTER TABLE `__new_player_prize_beneficiaries` RENAME TO `player_prize_beneficiaries`;