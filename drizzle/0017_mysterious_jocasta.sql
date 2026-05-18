CREATE TABLE `game_rounds` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`game_id` integer NOT NULL,
	`round_number` integer NOT NULL,
	`initial_combination_id` integer NOT NULL,
	FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`initial_combination_id`) REFERENCES `initial_combinations`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `game_rounds_game_id_round_number_unique` ON `game_rounds` (`game_id`,`round_number`);--> statement-breakpoint
ALTER TABLE `game_items` ADD `round_number` integer;