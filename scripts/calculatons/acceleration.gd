extends Node

class_name Utils  

static func drag(v:Vector3) -> Vector3:
	return v*v.length()*(-0.1)

# Вычисляет вектор тяги
static func calculate_thrust(proc: float, h:float, psi:float, fi:float, teta:float ) -> Vector3:
	var pitch_rotation = Basis().rotated(Vector3(1, 0, 0), teta)  # Вращение вокруг оси X
	var yaw_rotation = Basis().rotated(Vector3(0, 1, 0), psi)      # Вращение вокруг оси Y
	var roll_rotation = Basis().rotated(Vector3(0, 0, 1), fi) 
	# Комбинируем все повороты
	var rotation_matrix = yaw_rotation * pitch_rotation * roll_rotation
	return rotation_matrix*Vector3(0,1,0)*exp(-h/8500)*proc*20

static func acceleration(v:Vector3,m:float, g:float, proc: float, h:float, psi:float, fi:float, teta:float) -> Vector3:
	return calculate_thrust(proc,h,psi,fi,teta)/m-Vector3(0,g,0)+drag(v)
