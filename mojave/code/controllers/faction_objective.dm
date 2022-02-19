#define RAIDER "raider"

SUBSYSTEM_DEF(faction_objective)
	name = "Faction Objective"
	flags = SS_KEEP_TIMING
	wait = 10 SECONDS
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/datum/faction/factions = list()
	var/list/datum/component/capture_point/capture_points = list()

/datum/controller/subsystem/faction_objective/Initialize(start_timeofday)
	. = ..()

	for(var/faction in subtypesof(/datum/faction))
		// TODO: add map check here
		var/new_faction = new faction()
		var/name = new_faction.id
		factions[name] += new_faction

/datum/controller/subsystem/faction_objective/fire(resumed)
	for(var/datum/component/capture_point/capture_point in capture_points)
		factions[capture_point.faction].points += 1

/datum/controller/subsystem/faction_objective/proc/register_capture_point(datum/component/capture_point/capture_point)
	capture_points |= capture_point
	RegisterSignal(capture_point, COMSIG_PARENT_QDELETING, .proc/capture_point_deleted)

/datum/controller/subsystem/faction_objective/proc/capture_point_deleted(datum/component/capture_point/capture_point)
	SIGNAL_HANDLER
	capture_points -= capture_point
