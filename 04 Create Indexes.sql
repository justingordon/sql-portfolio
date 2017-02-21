
--dbo.BallType
create nonclustered index IDX_BallType_BallName on dbo.BallType(BallName);

--dbo.Drawing
create nonclustered index IDX_Drawing_DrawingDate on dbo.Drawing(DrawingDate);
create nonclustered index IDX_Drawing_GameId on dbo.Drawing(GameId);


--dbo.Game
create nonclustered index IDX_Game_GameName on dbo.Game(GameName);
create nonclustered index IDX_Game_Cost on dbo.Game(Cost);


--dbo.GameState
create nonclustered index IDX_GameState_GameId on dbo.GameState(GameId);
create nonclustered index IDX_GameState_Stateid on dbo.GameState(StateId);


--dbo.MatchOddsWinnings
create nonclustered index IDX_MatchOddsWinnings_Winnings on dbo.MatchOddsWinnings(Winnings);
create nonclustered index IDX_MatchOddsWinnings_GameId on dbo.MatchOddsWinnings(GameId);


--dbo.State
create nonclustered index IDX_State_State on dbo.State(State);


--dbo.WinningNumber
create nonclustered index IDX_WinningNumber_WinningNumber on dbo.WinningNumber(WinningNumber);
create nonclustered index IDX_WinningNumber_BallTypeId on dbo.WinningNumber(BallTypeId);
create nonclustered index IDX_WinningNumber_DrawingId on dbo.WinningNumber(DrawingId);