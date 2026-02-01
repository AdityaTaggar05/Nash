import {Pool} from "pg";

export class expirationChecker {
    private pool: Pool;
    private isRunning: boolean = false;
    private pollingIntervalMs: number = 10000;

    constructor(pool: Pool) {
        this.pool = pool;
    }

    public start() {
        if (this.isRunning) return;
        this.isRunning = true;
        this.loop();
    }

    private async loop() {
        try {
            await this.processBets();
        } catch (error) {
            console.error('Error in poller:', error);
        } finally {
            if (this.isRunning) {
                setTimeout(() => this.loop(), this.pollingIntervalMs);
            }
        }
    }

    private async processBets() {
        const openBets = await this.pool.query(`SELECT * FROM bets WHERE status = $1`,['open'])
        const time = new Date(Date.now());

        openBets.rows.forEach((bet)=> {
            if(Date.parse(bet.expires_at)<Date.parse(time.toString())) {
                this.pool.query(`UPDATE bets SET status = $1 WHERE id = $2`,['locked',bet.id])
            }
        })
    }
}