import { createClient } from '@libsql/client';
import { drizzle } from 'drizzle-orm/libsql';
import * as schema from './schema.ts';
import { env } from '../../env.ts';

const url = env.DATABASE_URL;
const authToken = env.DATABASE_AUTH_TOKEN;

const client = createClient({ url, authToken });

export const db = drizzle(client, { schema });
