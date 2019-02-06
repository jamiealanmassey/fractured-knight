extends "res://addons/gut/test.gd"


func before_all():
	gut.p("ran run setup", 2)


func test_something_else():
	assert_true(false, "didn't work")
	