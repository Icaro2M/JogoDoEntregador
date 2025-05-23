extends Area3D

@export var North : NodePath
@export var South : NodePath
@export var East : NodePath
@export var West : NodePath

@onready var north :=get_node(North)
@onready var south :=get_node(South)
@onready var east :=get_node(East)
@onready var west :=get_node(West)
