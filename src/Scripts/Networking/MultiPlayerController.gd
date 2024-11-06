extends Control

@export var Address = "127.0.0.1"
@export var port = 8910
# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#this gets called on the server and clients
func peer_connected(id):
	print("player connected " + str(id))
#this gets called on the server and clients
func peer_disconnected(id):
	print("player disconnected " + str(id))
#called only from clients
func connected_to_server():
	print("connected to server!")
#called only from clients
func connection_failed():
	print("connection failed!")

func _on_host_button_down():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("cannot host:" + error)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for Players!")

func _on_join_button_down():
	pass # Replace with function body.


func _on_start_game_button_down():
	pass # Replace with function body.
