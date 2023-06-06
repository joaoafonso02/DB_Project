<script>
	import { onMount } from 'svelte';

	let messagesBox;
	let myUsername = '';
	let chats = [];
	let searchInput = ''; 
	let usernames = [];
	let filteredChats = [];


	onMount(async () => {
		// if(openChat) messagesBox.scroll({ top: messagesBox.scrollHeight, behavior: 'smooth' });

		myUsername = localStorage.getItem('username');
		// getChats
		let resp = await fetch('http://localhost:5004/post_my_chats', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken')
			})
		});
		chats = await resp.json();

		fetchChats();
	});


	let openChat = false;
	let chatName = 'test';

	let openAdd = false;
	let textBoxValue = '';

	let messages = [];
	let current_group_id = -1;

	async function refreshChat() {
		let resp = await fetch('http://localhost:5004/post_my_messages', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken'),
				group_id: current_group_id
			})
		});
		messages = await resp.json();
	}

	let refreshInterval;
	async function openChatAction(event, group_id) {
		current_group_id = group_id;
		chatName = event.target.innerText;
		openChat = true;

		// load group messages
		refreshChat();
		refreshInterval = setInterval(() => {
			refreshChat();
			setTimeout(() => {
				messagesBox.scroll({ top: messagesBox.scrollHeight, behavior: 'smooth' });
			}, 1);
		}, 250);
	}

	async function closeChatAction(event) {
		openChat = false;
		clearInterval(refreshInterval);
	}

	async function send_message_keypress(event) {
		if (event.keyCode == 13) {
			send_message();
		}
	}
	async function send_message(event) {
		console.log(messagesBox);
		if (textBoxValue == '') return;

		// send message to bd
		let resp = await fetch('http://localhost:5004/post_send_message', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken'),
				msg_text: textBoxValue,
				group_id: current_group_id
			})
		});
		// messages = await resp.json();
		textBoxValue = '';
		setTimeout(() => {
			messagesBox.scroll({ top: messagesBox.scrollHeight, behavior: 'smooth' });
		}, 1);
	}

	let newChatTitle = "";
	let newChatUsers = "";
	async function create_new_chat() {
		openAdd = true;
	}

	async function fetchChats() {
		let resp2 = await fetch('http://localhost:5004/post_my_chats', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken')
			})
		});
		chats = await resp2.json();
	}
	
	async function create_new_chat_submit() {
		openAdd = true;
		console.log(newChatTitle, newChatUsers.split(" "))
		let resp = await fetch('http://localhost:5004/post_new_chat', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken'),
				title: newChatTitle,
				usernames: (myUsername+" "+newChatUsers).split(" ")
			})
		});
		openAdd = false;
		fetchChats();
	}

	async function delete_chat(event, group_id) {
		event.stopPropagation();
		let resp2 = await fetch('http://localhost:5004/post_delete_chat', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken'),
				group_id
			})
		});
		fetchChats();
	}

	// async function fetchUsernames() {
	// 	try {
	// 		const resp = await fetch('http://localhost:5004/post_usernames', {
	// 		method: 'POST',
	// 		headers: {
	// 			'Content-Type': 'application/json'
	// 		},
	// 		body: JSON.stringify({
	// 			utoken: localStorage.getItem('utoken')
	// 		})
	// 		});

	// 		const usernames = await resp.json();
	// 		return usernames;
	// 	} catch (error) {
	// 		console.error(error);
	// 		return [];
	// 	}
	// }

	// async function searchUsernames() {
	// 	// Filter the usernames based on the search input
	// 	return usernames.filter(username => username.includes(searchInput));
	// }

	async function filterChats() {
		if (searchInput === '') {
			filteredChats = chats;
		} else {
			let resp = await fetch('http://localhost:5004/post_filter_chats_sql', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				username: localStorage.getItem('username'),
				utoken: localStorage.getItem('utoken'),
				searchInput: searchInput
			})
		});

		filteredChats = await resp.json();
		}
	}


</script>

{#if !openChat && !openAdd}
	<div class="position-relative w-100 h-100">
		<div
			id="topbar"
			class="position-absolute w-100 d-flex align-items-center justify-content-between"
			style="background:#ddd"
		>
			<button onclick="window.location.href='/map'" class="btn h-100 p-0" style="width:50px;">
				<i class="fa fa-arrow-left" style="font-size:1.5rem;" />
			</button>
			<span class="" style="text-align:center;font-size:1.5rem;font-weight:bolder;">Chats</span>
			<button on:click={create_new_chat} class="btn h-100 p-0" style="width:50px;">
				<i class="fa fa-plus" style="font-size:1.5rem;" />
			</button>
		</div>
		<div style="margin-top:70px;">
			<div class="input-group input-group-sm" style="margin-left:5%;text-align:center;width: 90%">
				<span class="input-group-text" id="basic-addon1">
				  <i class="fa fa-search" />
				</span>
				<!-- <input
					type="text"
					class="form-control"
					placeholder="User Search"
					aria-label="Search"
					aria-describedby="basic-addon1"
					bind:value={searchInput}
					on:input={fetchUsernames}
					/> -->
					<input type="text" bind:value={searchInput} on:input={filterChats} placeholder="Search chats" />

				<!-- Dropdown with usernames -->
				<!-- <div class="dropdown">
					<button
					  class="btn btn-outline-secondary dropdown-toggle"
					  type="button"
					  id="dropdownMenuButton"
					  data-bs-toggle="dropdown"
					  aria-expanded="false"
					>
					  <i class="fa fa-filter"></i>
					</button>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					  {#each searchUsernames() as username}
					  <li>
						<a class="dropdown-item" href="#" on:click={() => searchInput = username}>{username}</a>
					  </li>
					  {/each}
					</ul>
				  </div> -->
				  
			</div>
				  
			<div class="list-group mt-3">
				{#if filteredChats.length}
				  {#each filteredChats as chat}
					<button
					  id="chatButton"
					  on:click={openChatAction(event, chat.group_id)}
					  class="position-relative list-group-item list-group-item-action rounded-0"
					>
					  {chat.group_name}
					  <button
						on:click={delete_chat(event, chat.group_id)}
						id="chatDeleteButton"
						class="position-absolute end-0 top-50 translate-middle text-danger px-2 border-0"
						style=""
					  >
						<i class="fa fa-trash " />
					  </button>
					  <span id="chatSpanButton" class="position-absolute w-100 h-100 top-0 start-0"></span>
					</button>
				  {/each}
				{:else if chats.length}
				  {#each chats as chat}
					<button
					  id="chatButton"
					  on:click={openChatAction(event, chat.group_id)}
					  class="position-relative list-group-item list-group-item-action rounded-0"
					>
					  {chat.group_name}
					  <button
						on:click={delete_chat(event, chat.group_id)}
						id="chatDeleteButton"
						class="position-absolute end-0 top-50 translate-middle text-danger px-2 border-0"
						style=""
					  >
						<i class="fa fa-trash " />
					  </button>
					  <span id="chatSpanButton" class="position-absolute w-100 h-100 top-0 start-0"></span>
					</button>
				  {/each}
				{:else}
				  <div class="text-center my-5">Loading Your Chats...</div>
				{/if}
			  </div>
		</div>
	</div>
{:else if openChat}
	<div class="position-relative w-100 h-100">
		<div
			id="topbar"
			class="position-absolute w-100 d-flex align-items-center justify-content-between"
			style="background:#ddd"
		>
			<button on:click={closeChatAction} class="btn h-100 p-0" style="width:50px;">
				<i class="fa fa-arrow-left" style="font-size:1.5rem;" />
			</button>
			<span class="" style="text-align:center;font-size:1.5rem;font-weight:bolder;">{chatName}</span
			>
			<button class="btn h-100 p-0" style="width:50px;">
				<i class="fa fa-plus" style="font-size:1.5rem;" />
			</button>
		</div>
		<div
			bind:this={messagesBox}
			id="messagesBox"
			class="w-100 overflow-auto p-2"
			style="margin-top: 50px;"
		>
			{#each messages as msg}
				{#if msg.username == myUsername}
					<div class="d-flex justify-content-end">
						<div
							class=" my-2 rounded-3 p-2 shadow"
							style="background:#585;width:fit-content;max-width:80%;"
						>
							<span style="font-size:0.6rem"
								>{new Date(msg.sent_at).getHours()}:{new Date(msg.sent_at).getMinutes()}</span
							>
							{msg.msg_text}
						</div>
					</div>
				{:else}
					<div
						class=" my-2 rounded-3 p-2 shadow"
						style="background:#ccc;width:fit-content;max-width:80%;"
					>
						<div class="" style="font-size:0.7rem;">{msg.username}</div>
						<div>
							{msg.msg_text}
							<span style="font-size:0.6rem"
								>{new Date(msg.sent_at).getHours()}:{new Date(msg.sent_at).getMinutes()}</span
							>
						</div>
					</div>
				{/if}
			{/each}
		</div>
		<div class="position-absolute w-100 bottom-0 p-0" style="height: 50px;">
			<div class="d-flex align-items-center">
				<input
					id="text_message"
					class="form-control h-100 mx-1"
					placeholder="Type your message..."
					style="width:90%;"
					bind:value={textBoxValue}
					on:keypress={send_message_keypress}
				/>
				<button on:click={send_message} id="send_message" class="btn btn-secondary h-100 mx-1">
					<i class="fa fa-send" style="" />
				</button>
			</div>
		</div>
	</div>
{:else if openAdd}
	<div class="position-relative w-100 h-100 p-5">
		<h1>Create a New Chat</h1>
		<form>
			<div class="form-group my-2">
				<label for="chatTitle">Chat Title</label>
				<input bind:value={newChatTitle} type="text" class="form-control" id="chatTitle" placeholder="Enter chat title" />
			</div>
			<div class="form-group my-2">
				<label for="userGroup">Group of Users</label>
				<input
					bind:value={newChatUsers}
					type="text"
					class="form-control"
					id="userGroup"
					placeholder="Enter users separated by space"
				/>
			</div>
			<button on:click={create_new_chat_submit} class="btn btn-primary my-2">Create Chat</button>
		</form>
	</div>
{/if}

<style>
	#topbar {
		height: 50px;
	}
	#messagesBox {
		height: calc(100% - 100px);
	}
	#chatDeleteButton {
		z-index:1000;
		background: none;
	}
	#chatDeleteButton:hover {
	}
	#chatDeleteButton:hover ~ #chatSpanButton  {  
		background: rgba(255,0,0,0.4);
	}

</style>
