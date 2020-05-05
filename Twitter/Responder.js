const { Autohook} = require('twitter-autohook');
const util = require('util');
const request = require('request');

const post = util.promisify(request.post);

process.env['TWITTER_CONSUMER_KEY'] = '7NTFSTNtTxGA76ODLqGIRHCpZ';
process.env['TWITTER_CONSUMER_SECRET'] = '7ShuK7g0KtvKlVEECyMAY5E9k5cdNRYTGHb64FAtr9eNzzc5Nf';
process.env['TWITTER_ACCESS_TOKEN'] = '1223485018816692224-BYwUKX28FQEDpEM3zvI9RdVSq9pm7v';
process.env['TWITTER_ACCESS_TOKEN_SECRET'] = 'ZYvOGRkin0HaHSRB8QzR0VC1F5i64vhFRMFGvn85uJwHt';
process.env['TWITTER_WEBHOOK_ENV'] = 'env';

const oAuthConfig = {
    token: process.env.TWITTER_ACCESS_TOKEN,
    token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET,
    consumer_key: process.env.TWITTER_CONSUMER_KEY,
    consumer_secret: process.env.TWITTER_CONSUMER_SECRET,
};

async function markAsRead(messageId, senderId, auth) {
    const requestConfig = {
        url: 'https://api.twitter.com/1.1/direct_messages/mark_read.json',
        form: {
            last_read_event_id: messageId,
            recipient_id: senderId,
        },
        oauth: auth,
    };

    await post(requestConfig);
}

async function indicateTyping(senderId, auth) {
    const requestConfig = {
        url: 'https://api.twitter.com/1.1/direct_messages/indicate_typing.json',
        form: {
            recipient_id: senderId,
        },
        oauth: auth,
    };

    await post(requestConfig);
}

async function sayMessage(event) {
    if (!event.direct_message_events) {
        return;
    }

    const message = event.direct_message_events.shift();

    if (typeof message === 'undefined' || typeof message.message_create === 'undefined') {
        return;
    }

    if (message.message_create.sender_id === message.message_create.target.recipient_id) {
        return;
    }

    await markAsRead(message.message_create.id, message.message_create.sender_id, oAuthConfig);
    await indicateTyping(message.message_create.sender_id, oAuthConfig);

    const senderScreenName = event.users[message.message_create.sender_id].screen_name;
    console.log(`${senderScreenName} says ${message.message_create.message_data.text}`);

    const requestConfig = {
        url: 'https://api.twitter.com/1.1/direct_messages/events/new.json',
        oauth: oAuthConfig,
        json: {
            event: {
                type: 'message_create',
                message_create: {
                    target: {
                        recipient_id: message.message_create.sender_id,
                    },
                    message_data: {
                        text: `Hi @${senderScreenName}! 👋`,
                    },
                },
            },
        },
    };
    await post(requestConfig);
}

function sleep(ms){
    return new Promise(resolve=>{
        setTimeout(resolve,ms)
    })
}

(async start => {
    try {
        const webhook = new Autohook();
        await webhook.removeWebhooks();
        await webhook.start();

        webhook.on('event', async event => {
            if (event.direct_message_events) {
                await sayMessage(event);
            }
        });

        await webhook.subscribe({oauth_token: process.env.TWITTER_ACCESS_TOKEN, oauth_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET});
    } catch (e) {
        console.error(e);
        if (e.name === 'RateLimitError') {
            await sleep(e.resetAt - new Date().getTime());
            process.exit(1);
        }
    }
})();
