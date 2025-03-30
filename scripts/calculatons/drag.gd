extends Node

static func drag(v:Vector3) -> Vector3:
	return v*v.length()*(-0.06)
