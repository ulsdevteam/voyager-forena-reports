--ACCESS=access content
select fft.fine_fee_type,
	fft.fine_fee_desc
from
	pittdb.fine_fee_type fft
order by
	fft.fine_fee_desc
