<script>
	let openChat = false;
	let chatName = 'test';

	let openAdd = false;

	let messages = [
		{ username: 'edu', message: 'something', date: new Date(Date.now()) },
		{ username: 'bah', message: 'something else', date: new Date(Date.now()) },
		{
			username: 'edu',
			message: 'a really long message that never seems to end',
			date: new Date(Date.now())
		},
		{ username: 'bah', message: 'ok', date: new Date(Date.now()) },
		{ username: 'edu', message: 'then', date: new Date(Date.now()) },
		{ username: 'edu', message: 'something', date: new Date(Date.now()) },
		{ username: 'bah', message: 'something else', date: new Date(Date.now()) },
		{
			username: 'edu',
			message: 'a really long message that never seems to end',
			date: new Date(Date.now())
		},
		{ username: 'bah', message: 'ok', date: new Date(Date.now()) },
		{ username: 'edu', message: 'then', date: new Date(Date.now()) },
		{ username: 'edu', message: 'something', date: new Date(Date.now()) },
		{ username: 'bah', message: 'something else', date: new Date(Date.now()) },
		{
			username: 'edu',
			message: 'a really long message that never seems to end',
			date: new Date(Date.now())
		},
		{ username: 'bah', message: 'ok', date: new Date(Date.now()) },
		{ username: 'edu', message: 'then', date: new Date(Date.now()) }
	];

	async function openChatAction(event) {
		console.log(typeof event);
		chatName = event.target.innerText;
		openChat = true;
	}

    async function closeChatAction(event) {
        openChat = false;
    }

	let messagesBox;
	async function send_message(event) {
		console.log(messagesBox);
		messagesBox.scroll({ top: messagesBox.scrollHeight, behavior: 'smooth' });
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
			<button class="btn h-100 p-0" style="width:50px;">
				<i class="fa fa-plus" style="font-size:1.5rem;" />
			</button>
		</div>
		<div style="margin-top:50px;">
			<div class="list-group">
				<button on:click={openChatAction} class="list-group-item list-group-item-action rounded-0"
					>O caralho</button
				>
				<button on:click={openChatAction} class="list-group-item list-group-item-action rounded-0"
					>A tua prima</button
				>
				<button on:click={openChatAction} class="list-group-item list-group-item-action rounded-0"
					>Cota</button
				>
				<button on:click={openChatAction} class="list-group-item list-group-item-action rounded-0"
					>Banana</button
				>
				<button on:click={openChatAction} class="list-group-item list-group-item-action rounded-0"
					>BAH</button
				>
			</div>
		</div>
	</div>
{/if}
{#if openChat}
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
				{#if msg.username == 'edu'}
					<div class="d-flex justify-content-end">
						<div
							class=" my-2 rounded-3 p-2 shadow"
							style="background:#585;width:fit-content;max-width:80%;"
						>
							{msg.message}
						</div>
					</div>
				{:else}
					<div class=" my-2 rounded-3 p-2 shadow" style="background:#ccc;width:fit-content;max-width:80%;">
						{msg.message}
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
				/>
				<button on:click={send_message} id="send_message" class="btn btn-secondary h-100 mx-1">
					<i class="fa fa-send" style="" />
				</button>
			</div>
		</div>
	</div>
{/if}

<style>
	#topbar {
		height: 50px;
	}
	#messagesBox {
		height: calc(100% - 100px);
	}
</style>
