import { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";

export async function routes(instance: FastifyInstance) {
    instance.get('/ping', async (request: FastifyRequest, reply: FastifyReply) => {
        reply.send({ message: 'pong' })
    });
}