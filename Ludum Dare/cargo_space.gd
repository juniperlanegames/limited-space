extends Node2D

@onready var overlapping = $CanvasLayer/Control/Overlapping
@onready var background = $Background

@onready var blueOverlapping = preload("res://Sprites/OverlappingButtons/Blue.png")
@onready var redOverlapping = preload("res://Sprites/OverlappingButtons/Red.png")

const cargoPiecesShapes = [
	[Vector2(0, 0), Vector2(1, 0), Vector2(0, 1)],
	[Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)],
	[Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0), Vector2(1, 1)],
	[Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0)]
]

const gridSize = Vector2(8, 6) # Size of the grid (in cells)
const cellSize = Vector2(64, 64) # Size of the individual cells

var grid

var currentPieceID
var currentPiece
var currentRotation = 0


func _ready():
	grid = getEmptyGrid(gridSize)
	background.scale = (gridSize + Vector2(1, 1)) * cellSize
	background.position = background.scale / 2 - cellSize


func _process(_delta):
	if Input.is_action_just_pressed("Left") and currentPiece != null:
		currentRotation -= 0.5 * PI
		currentPiece.rotate(-0.5 * PI)
	if Input.is_action_just_pressed("Right") and currentPiece != null:
		currentRotation += 0.5 * PI
		currentPiece.rotate(0.5 * PI)
	
	if currentPiece != null:
		currentPiece.position = snap(get_global_mouse_position(), cellSize)
		if pieceOverlaps():
			overlapping.texture = redOverlapping
			currentPiece.hide()
		else:
			overlapping.texture = blueOverlapping
			currentPiece.show()
	
	if Input.is_action_just_pressed("ui_accept"):
		if currentPieceID == null:
			spawnPiece()
		elif !pieceOverlaps():
			var pieceShape = cargoPiecesShapes[currentPieceID]
			for pos in pieceShape:
				grid[pos.x + currentPiece.position.x / cellSize.x][pos.y + currentPiece.position.y / cellSize.y] = true
			
			currentPiece = null
			currentPieceID = null
	
	if Input.is_action_just_pressed("ui_end"):
		printGrid()


func spawnPiece(id:int=-1):
	if id == -1:
		id = randi_range(0, 3)
	
	var pieceInstance = Sprite2D.new()
	pieceInstance.texture = load("res://Sprites/Pieces/Piece" + str(id) + ".png")
	add_child(pieceInstance)
	currentPiece = pieceInstance
	currentPieceID = id
	currentPiece.position = snap(get_global_mouse_position(), cellSize)
	currentRotation = 0


func pieceOverlaps():
	var shape = cargoPiecesShapes[currentPieceID]
	var currentPiecePos = snap(currentPiece.position, cellSize)
	for pos in shape:
		var newPos = (pos.rotated(currentRotation) + currentPiecePos / cellSize).round()
		print(newPos)
		if clamp(int(newPos.x), 0, gridSize.x - 1) == newPos.x and clamp(int(newPos.y), 0, gridSize.y - 1) == newPos.y:
			if grid[newPos.x][newPos.y]:
				print("f")
				return true
		else:
			print("c")
			print(int(1))
			print(int(newPos.x))
			print(clamp(int(newPos.x), 0, gridSize.x - 1))
			print(clamp(int(newPos.y), 0, gridSize.y - 1))
			return true
	return false


func snap(pos:Vector2, cellSize:Vector2):
	return (pos / cellSize).round() * cellSize


func getEmptyGrid(size:Vector2):
	var g = []
	for x in range(size.x):
		var r = []
		for y in range(size.y):
			r.append(false)
		g.append(r)
	return g


func printGrid():
	for col in grid:
		print(col)
