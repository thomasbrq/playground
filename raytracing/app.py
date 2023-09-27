from dataclasses import dataclass
from math import sqrt

@dataclass
class Vec3:
	x: float = 0.0
	y: float = 0.0
	z: float = 0.0

	def sub(self, other):
		return Vec3(self.x - other.x, self.y - other.y, self.z - other.z)

	def add(self, other):
		return Vec3(self.x + other.x, self.y + other.y, self.z + other.z)

	def nmultiply(self, n):
		return Vec3(self.x * n, self.y * n, self.z * n)

@dataclass
class Sphere:
	coords: Vec3 = Vec3(0, 0, 5)
	radius: int = 1
	color: Vec3 = Vec3(0, 0, 0)

# Globals
IMAGE_WIDTH=256
IMAGE_HEIGHT=256
DISTANCE = 250
ALPHA = 50
#####################

def direction(x, y):
	return Vec3(x - (IMAGE_WIDTH / 2), y - (IMAGE_HEIGHT / 2), DISTANCE )


def scalar(u, v):
	return u.x * v.x + u.y * v.y + u.z * v.z

def norm(u):
	return sqrt(scalar(u, u))

def normalize ( u ) :
	return Vec3 ( u . x / norm ( u ) , u . y / norm ( u ) , u . z / norm ( u ) )

def intersect(ray_direction, sphere_center, sphere_radius) -> float:
	a = 1
	b = -2 * scalar(ray_direction, sphere_center)
	c = norm(sphere_center) ** 2 - sphere_radius ** 2
	discriminant = b ** 2 - 4 * a * c

	if discriminant == 0:
		return max(-b / (2 * a), 0)
	elif discriminant > 0:
		x1 = (-b - sqrt(discriminant)) / (2 * a)
		x2 = (-b + sqrt(discriminant)) / (2 * a)
		return max(0, min(x1, x2))
   
	return 0

def specular_func(U, N, L, light_color):
	if scalar(L, N) > 0:
		a = N.nmultiply(scalar(N, U))
		b = a.nmultiply(2)
		c = U.sub(b)
		r = normalize(c)
		specular = light_color.nmultiply(scalar(L, r) ** ALPHA)
	else:
		specular = Vec3(0,0,0)
	
	return specular

def shading(ray, sphere, light, light_color):
	OM	= ray.nmultiply(intersect(ray, sphere.coords, sphere.radius))
	ML	= normalize(light.sub(OM))
	N 	= normalize(OM.sub(sphere.coords))
	L 	= normalize(ML)

	specular = specular_func(ray, N, L, light_color)
	color = sphere.color.nmultiply(max( scalar( N, L ), 0 ))

	return color.add(specular)

def render():
	file = open("image.ppm", "w")
	
	file.write(f"P3\n{IMAGE_WIDTH} {IMAGE_HEIGHT}\n255\n")

	light = Vec3(-15, -15, -15)
	light_color = Vec3(255, 255, 255)

	world_objects = [
		Sphere( Vec3(0, 1, 5), 0.5, Vec3(82, 163, 255) ),
		Sphere( Vec3(0, -1, 5), 1, Vec3(255, 82, 82) ),
		Sphere( Vec3(100, 1, -1), 100, Vec3(0, 255, 0)),
	]

	for x in range(IMAGE_WIDTH):
		for y in range(IMAGE_HEIGHT):
			ray = normalize(direction(x, y))
			intersection_found = False
			for sphere in world_objects:
				if intersect(ray, sphere.coords, sphere.radius) != 0:
					color = shading(ray, sphere, light, light_color)
					file.write(f"{color.x} {color.y} {color.z}\n")
					intersection_found = True
					break
			if not intersection_found:
				file.write("92 198 255\n")

	file.close()
	
render()