export interface OpenPlacedBetResponseDTO {
  id: string;
  title: string;
  expires_at: Date;
  created_at: Date;
  total_pot: number;
  my_bet?: {
    amount: number;
    option: string;
  };
}
