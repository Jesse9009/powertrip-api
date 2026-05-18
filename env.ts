/* 
    Centralized environment configuration. Loads the correct .env file based on APP_STAGE,
    validates all required variables against a Zod schema at startup, and exports a typed
    `env` object — providing full type safety and auto-complete for env vars throughout
    the app. The process exits immediately with a descriptive error if any variable is
    missing or malformed — catching misconfigurations before the server starts.
*/
import { env as loadEnv } from 'custom-env';
import { z } from 'zod';

process.env.APP_STAGE = process.env.APP_STAGE || 'dev';

const isDevelopment = process.env.APP_STAGE === 'dev';
const isTesting = process.env.APP_STAGE === 'test';

if (isDevelopment) {
  loadEnv();
} else if (isTesting) {
  loadEnv('test');
}

const envSchema = z.object({
  NODE_ENV: z
    .enum(['development', 'test', 'production'])
    .default('development'),

  APP_STAGE: z.enum(['dev', 'test', 'production']).default('dev'),

  PORT: z.coerce.number().positive().default(3000),
  DATABASE_URL: z.string().startsWith('libsql://'),
  DATABASE_AUTH_TOKEN: z.string().min(1, 'DATABASE_AUTH_TOKEN is required'),
  BETTER_AUTH_SECRET: z.string().min(1, 'BETTER_AUTH_SECRET is required'),
});

export type Env = z.infer<typeof envSchema>;
let env: Env;

try {
  env = envSchema.parse(process.env);
} catch (e) {
  if (e instanceof z.ZodError) {
    console.log('Invalid env var');
    console.error(JSON.stringify(e.flatten().fieldErrors, null, 2));

    e.issues.forEach((err) => {
      const path = err.path.join('.');
      console.log(`${path}: ${err.message}`);
    });

    process.exit(1);
  }

  throw e;
}

export const isProd = () => env.APP_STAGE === 'production';
export const isDev = () => env.APP_STAGE === 'dev';
export const isTest = () => env.APP_STAGE === 'test';

export { env };
export default env;
