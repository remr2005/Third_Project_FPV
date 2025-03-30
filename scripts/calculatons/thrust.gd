extends Node

# Вычисляет вектор тяги
static func calculate_thrust(proc: float, h:float, psi:float, fi:float, teta:float ) -> Vector3:
	return Vector3(cos(fi)*cos(psi)-sin(fi)*sin(teta)*sin(psi),cos(teta)*sin(psi),sin(fi)*cos(psi)+cos(fi)*sin(teta)*sin(psi))*exp(-h/8500)*proc*60
	
