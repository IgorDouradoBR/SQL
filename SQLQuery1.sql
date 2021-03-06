CREATE TABLE [Bookings] (
  [ID_booking] int identity, 	
  [hotel] VARCHAR(100),
  [is_canceled] bit,
  [lead_time] int,
  [arrival_date_year] int,
  [arrival_date_month] VARCHAR(100),
  [arrival_date_week_number] int,
  [arrival_date_day_of_month] int,
  [stays_in_weekend_nights] int,
  [stays_in_week_nights] int,
  [adults] int,
  [children] int,
  [babies] int,
  [meal] VARCHAR(100),
  [country] VARCHAR(100),
  [market_segment] VARCHAR(100),
  [distribution_channel] VARCHAR(100),
  [is_repeated_guest] bit,
  [previous_cancellations] int,
  [previous_bookings_not_canceled] int,
  [reserved_room_type] VARCHAR(100),
  [assigned_room_type] VARCHAR(100),
  [booking_changes] int,
  [deposit_type] VARCHAR(100),
  [agent] VARCHAR(100),
  [company] VARCHAR(100),
  [days_in_waiting_list] int,
  [customer_type] VARCHAR(100),
  [adr] int,
  [required_car_parking_spaces] int,
  [total_of_special_requests] int,
  [reservation_status] VARCHAR(100),
  [reservation_status_date] VARCHAR(100)
)
GO
