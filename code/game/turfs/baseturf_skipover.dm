// This is a typepath to just sit in baseturfs and act as a marker for other things.
/turf/baseturf_skipover
	name = "Baseturf skipover placeholder"
	desc = "This shouldn't exist"

/turf/baseturf_skipover/Initialize()
	. = ..()
	stack_trace("[src]([type]) was instanced which should never happen. Changing into the next baseturf down...")
	ScrapeAway()

/turf/baseturf_skipover/shuttle
	name = "Shuttle baseturf skipover"
	desc = "Acts as the bottom of the shuttle, if this isn't here the shuttle floor is broken through."

/turf/baseturf_skipover/train
	name = "Train baseturf skipover"
	desc = "Пробитый пол в поезде мгновенно заменяется этим который заменяется на спрайт двигающегося пола."

/turf/baseturf_skipover/lift
	name = "Lift baseturf skipover"
	desc = "Пробитый пол в лифте мгновенно заменяется плиткой."