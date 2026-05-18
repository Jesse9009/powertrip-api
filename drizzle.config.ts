import 'dotenv/config';
import { defineConfig } from 'drizzle-kit';
import { env } from './env.ts';

export default defineConfig({
  schema: './src/db/schema.ts',
  out: './drizzle',
  dialect: 'turso',
  dbCredentials: {
    url: env.DATABASE_URL ?? '',
    authToken: env.DATABASE_AUTH_TOKEN,
  },
  strict: true,
  verbose: true,
});
