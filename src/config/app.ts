import { config } from "dotenv";
import path from "path";

const envFile = process.env.NODE_ENV === 'production' ? '.env.production' : '.env.development';
config({ path:path.resolve(__dirname, '../../', envFile) })
export const PORT = process.env.PORT || 3002;
