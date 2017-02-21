SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Justin Gordon
-- Create date: 11.19.2015
-- Description:	This procedure retrieves Person
--				record(s)
-- =============================================
CREATE PROCEDURE dbo.usp_GetPerson(
	@PersonId	int = null,
	@QueryId	int = 10
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto GET_ITEM end;
	if(@QueryId = 20) begin goto GET_COLLECTION end;

	goto EXIT_SECTION



--BEGIN:	GET_ITEM SECTION
GET_ITEM:
	begin
		select	a.Title,
				a.FirstName,
				a.LastName,
				a.DisplayFirstName,
				a.Gender
		from	dbo.person a
		where	a.PersonId = @PersonId;

		goto EXIT_SECTION
	end
--END:		GET_ITEM SECTION





--BEGIN:	GET_COLLECTION SECTION
GET_COLLECTION:
	begin
		select		a.Title,
					a.FirstName,
					a.LastName,
					a.DisplayFirstName,
					a.Gender
		from		dbo.person a
		order by	a.LastName,
					a.FirstName

		goto EXIT_SECTION
	end

--END:		GET_COLLECTION SECTION


--BEGIN:	EXIT_SECTION
	EXIT_SECTION:
--END:		EXIT_SECTION
END
GO
