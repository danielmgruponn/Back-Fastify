-- CreateEnum
CREATE TYPE "Status" AS ENUM ('ACTIVE', 'PENDING', 'INACTIVE');

-- CreateTable
CREATE TABLE "Rol" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(191) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Rol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" VARCHAR(255) NOT NULL,
    "rolId" BIGINT NOT NULL,
    "name" VARCHAR(191) NOT NULL,
    "walletAddress" VARCHAR(191) NOT NULL,
    "percentage" DOUBLE PRECISION NOT NULL,
    "code" VARCHAR(10) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "email" VARCHAR(191) NOT NULL,
    "emailVerifiedAt" TIMESTAMP(0),
    "password" VARCHAR(191) NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "id" VARCHAR(255) NOT NULL,
    "name" VARCHAR(191) NOT NULL,
    "percentage" VARCHAR(191) NOT NULL,
    "buyedReward" VARCHAR(191) NOT NULL,
    "code" VARCHAR(10) NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GroupUser" (
    "id" VARCHAR(255) NOT NULL,
    "userId" VARCHAR(255) NOT NULL,
    "groupId" VARCHAR(255) NOT NULL,
    "percentage" VARCHAR(191) NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "GroupUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ticket" (
    "id" VARCHAR(255) NOT NULL,
    "deposit" DOUBLE PRECISION NOT NULL,
    "delivery" DOUBLE PRECISION NOT NULL,
    "discount" DOUBLE PRECISION NOT NULL,
    "nameBuyed" VARCHAR(191) NOT NULL,
    "walletBuyed" VARCHAR(191) NOT NULL,
    "code" VARCHAR(191) NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'PENDING',
    "file" VARCHAR(191) NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "Ticket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRewardTicket" (
    "id" VARCHAR(255) NOT NULL,
    "userId" VARCHAR(255) NOT NULL,
    "ticketId" VARCHAR(255) NOT NULL,
    "percentage" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "UserRewardTicket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TotalReservedStake" (
    "id" VARCHAR(255) NOT NULL,
    "wallet" VARCHAR(191) NOT NULL,
    "totalStaking" TEXT NOT NULL,
    "lastClaimed" TIMESTAMP(0) NOT NULL,
    "totalClaimed" TEXT,
    "status" "Status" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "TotalReservedStake_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GeneralReward" (
    "id" VARCHAR(255) NOT NULL,
    "percentage" DOUBLE PRECISION NOT NULL,
    "status" VARCHAR(191) NOT NULL DEFAULT 'active',
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,

    CONSTRAINT "GeneralReward_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserReward" (
    "id" VARCHAR(255) NOT NULL,
    "userId" VARCHAR(255) NOT NULL,
    "groupId" VARCHAR(255),
    "walletBuyed" VARCHAR(191) NOT NULL,
    "reward" DOUBLE PRECISION NOT NULL,
    "claimedReward" DOUBLE PRECISION NOT NULL,
    "status" "Status" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(0) NOT NULL,
    "updatedAt" TIMESTAMP(0) NOT NULL,
    "type" VARCHAR(191) NOT NULL,

    CONSTRAINT "UserReward_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_rolId_key" ON "User"("rolId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_rolId_fkey" FOREIGN KEY ("rolId") REFERENCES "Rol"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "GroupUser" ADD CONSTRAINT "GroupUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupUser" ADD CONSTRAINT "GroupUser_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRewardTicket" ADD CONSTRAINT "UserRewardTicket_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRewardTicket" ADD CONSTRAINT "UserRewardTicket_ticketId_fkey" FOREIGN KEY ("ticketId") REFERENCES "Ticket"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserReward" ADD CONSTRAINT "UserReward_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserReward" ADD CONSTRAINT "UserReward_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE SET NULL ON UPDATE CASCADE;
