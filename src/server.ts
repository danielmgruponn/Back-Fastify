import Fastify from "fastify";
import { routes } from './routes'
import { PORT } from "./config/app";

const fastify = Fastify({ logger: true })

fastify.register(routes)

const start = async () => {
    try {
        await fastify.listen(PORT);
        console.log(`Server is running at http://localhost:${PORT}`);
    } catch (error) {
        fastify.log.error(error)
        process.exit(1)
    }
};

start()
