
/* Primary Keys ***************************** */

alter table dbo.Drawing
add constraint PK_Drawing_DrawingId primary key(DrawingId);

alter table dbo.Game
add constraint PK_Game_GameId primary key(GameId);

alter table dbo.MatchOddsWinnings
add constraint PK_MatchOddsWinnings_MatchOddsWinningsId primary key(MatchOddsWinningsId);

alter table dbo.State
add constraint PK_State_StateId primary key(StateId);

alter table dbo.GameState
add constraint PK_GameState_GameStateId primary key(GameStateId);

alter table dbo.WinningNumber
add constraint PK_WinningNumber_WinningNumberId primary key(WinningNumberId);

alter table dbo.BallType
add constraint PK_BallType_BallTypeId primary key(BallTypeId);




/* Foreign Keys ***************************** */

alter table dbo.Drawing
add constraint FK_Drawing_GameId foreign key(GameId) references dbo.Game(GameId);

alter table dbo.MatchOddsWinnings
add constraint FK_MatchOddsWinnings_GameId foreign key(GameId) references dbo.Game(GameId);

alter table dbo.GameState
add constraint FK_GameState_GameId foreign key(GameId) references dbo.Game(GameId);

alter table dbo.GameState
add constraint FK_GameState_StateId foreign key(StateId) references dbo.State(StateId);

alter table dbo.WinningNumber
add constraint FK_WinningNumbers_BallTypeId foreign key(BallTypeId) references dbo.BallType(BallTypeId);

alter table dbo.WinningNumber
add constraint FK_WinningNumbers_DrawingId foreign key(DrawingId) references dbo.Drawing(DrawingId);