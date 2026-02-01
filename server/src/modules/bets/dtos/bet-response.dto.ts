export interface BetResponseDTO {
  id: string;
  title: string;
  group_id: string;
  creator_id: string;
  status: string;
  winning_option?: string;
  expires_at: Date;
  created_at: Date;
  created_by: string;
  total_pot: number;
  pool_for: number;
  pool_against: number;
  my_bet?: {
    amount: number;
    option: string;
    payout: number;
  };
}
