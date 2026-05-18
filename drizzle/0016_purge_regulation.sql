ALTER TABLE `game_item_participants` RENAME TO `game_tiebreaker_item_participants`;
--> statement-breakpoint
DELETE FROM `game_tiebreaker_item_participants`
WHERE game_item_id IN (
  SELECT id FROM game_items
  WHERE game_item_type_id = (
    SELECT id FROM game_item_types WHERE type = 'regulation'
  )
);
