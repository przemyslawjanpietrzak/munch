(function() {
    'use strict';

    const getMessage = (message, messageType) => 
`<div class="message-wrapper ${ messageType }">
    <div class="circle-wrapper animated bounceIn"></div>
    <div class="text-wrapper animated fadeIn">${ message }</div>
</div>`;

    const content = document.getElementById('content');
    const input = document.getElementById('input');
    const sendButton = document.getElementById('send');
    const inner = document.getElementById('inner');

    const fetchResponse = (message) => {
        fetch(`/painting/${ message }`)
            .then(response => response.json())
            .then(response => {
                const link = `<a href="${ response.url }" target="_blank">Link</a>`
                const element = document.createElement('div');
                element.innerHTML = getMessage(link, 'them');
                content.appendChild(element);
                inner.scroll({ top: inner.scrollHeight });
            })
            .catch(() => {
                const element = document.createElement('div');
                element.innerHTML = getMessage('not found', 'them');
                content.appendChild(element);
                inner.scroll({ top: inner.scrollHeight });
            });
    }

    sendButton.addEventListener('click', () => {
        const message = input.value;
        if (!message) {
            return;
        }
        const element = document.createElement('div');
        element.innerHTML = getMessage(message, 'me');
        content.appendChild(element);
        input.value = '';
        inner.scroll({ top: inner.scrollHeight });
        input.focus();
        fetchResponse(message);
    });

})()