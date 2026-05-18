CREATE TABLE `tournament_rounds` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`sort_order` integer NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `tournament_rounds_name_unique` ON `tournament_rounds` (`name`);--> statement-breakpoint
CREATE TABLE `tournaments` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`year` integer
);
--> statement-breakpoint
CREATE UNIQUE INDEX `tournaments_name_unique` ON `tournaments` (`name`);--> statement-breakpoint
ALTER TABLE `games` ADD `tournament_id` integer REFERENCES tournaments(id);--> statement-breakpoint
ALTER TABLE `games` ADD `tournament_round_id` integer REFERENCES tournament_rounds(id);