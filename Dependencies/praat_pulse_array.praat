form Voice_analysis
	text name ''
	real fricloc 0
	real offYN 0
	real filtYN 0
endform

clearinfo 

Read from file... 'name$'
fileName$ = selected$("Sound")

select Sound 'fileName$'
totalDuration = Get total duration


if fricloc > 0
		if offYN == 1 	
				Extract part: 0, fricloc, "rectangular", 1, "no"
		elsif offYN == 0
				Extract part: fricloc, totalDuration, "rectangular", 1, "no"
		endif
		selectObject: "Sound " + fileName$ + "_part"
		Rename: fileName$
endif

		
if filtYN == 1		
		Filter (pass Hann band): 60, 3000, 100
		selectObject: "Sound " + fileName$ + "_band"
		Rename: fileName$
endif

To PointProcess (periodic, cc)... 75 500
#To PointProcess (periodic, peaks): 75, 500, "yes", "yes"
select PointProcess 'fileName$'
numberOfPulses = Get number of points

for ii from 1 to numberOfPulses
		pulsei = Get time from index: ii
		appendInfoLine: 'pulsei'
endfor

