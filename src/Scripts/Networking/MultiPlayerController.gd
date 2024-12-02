extends Control

@export var Address = "127.0.0.1"
@export var port = 8910
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	var executable_path = OS.get_executable_path()
	var blocking = false
	OS.execute(executable_path, blocking)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		host_game()

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
	#1 refers to the server id
	send_player_information.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())
#called only from clients
func connection_failed():
	print("connection failed!")

@rpc("any_peer")
func send_player_information(name, id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id" : id,
			"score" : 0
		}
	
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_information.rpc(GameManager.players[i].name, i) #will send to everyone connected due to how rpc is setup
			
			
@rpc("any_peer", "call_local")
func start_game():
	var scene = load("res://src/Scenes/MultiplayerTestLevel.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

func host_game():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 2)
	if error != OK:
		print("cannot host:" + error)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for Players!")
	send_player_information($LineEdit.text, multiplayer.get_unique_id())

func _on_host_button_down():
	host_game()

func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)

func _on_start_game_button_down():
	start_game.rpc()
	
