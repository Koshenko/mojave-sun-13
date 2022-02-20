/datum/component/capture_point
	var/faction

/datum/component/capture_point/Initialize()
	SSfaction_objective.register_capture_point(src)

/datum/component/capture_point/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/examine)
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/capture)

/datum/component/capture_point/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_PARENT_EXAMINE,COMSIG_PARENT_ATTACKBY))

/datum/component/capture_point/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(faction)
		examine_list += span_notice("[SSfaction_objective.factions[faction].capture_description] [SSfaction_objective.factions[faction].points]")

/datum/component/capture_point/proc/capture()
	SIGNAL_HANDLER

	if(faction)
		return
	faction = RAIDER
	var/atom/capture_target = parent
	var/capture_overlay = mutable_appearance('icons/testing/greyscale_error.dmi')
	capture_target.add_overlay(capture_overlay)
