const { onSchedule } = require("firebase-functions/v2/scheduler");
const { onValueCreated } = require("firebase-functions/v2/database");
const admin = require("firebase-admin");

admin.initializeApp({
    databaseURL: "https://alphabet-of-default-rtdb.europe-west1.firebasedatabase.app/",
});

let recentPayloads = [];

exports.onDateCreated = onValueCreated(
    { ref: "/dates/{date_id}/alphabet/{character}/date", region: "europe-west1" },
    async (event) => {
        let p = event.params;
        let date = event.data.val();

        let users = await getDateUsers(p.date_id);
        if (!users || users.length === 0) return;

        await Promise.all(users.map(async (uid) => {
            const fcmToken = await getFcmToken(uid);
            if (fcmToken) {
                if (isToday(date)) {
                    const name = await admin.database().ref(`/dates/${p.date_id}/alphabet/${p.character}/name`).get();
                    await sendNotification(fcmToken, `🎉🎉 It's date day 🎉🎉`, `What are we doing? ${name.val()}!!`);
                }
                else {
                    await sendNotification(fcmToken, `An activity has been chosen for ${p.character} 👀`, `${funPhrase(p.character)}\nFind out what we're doing ${formatDate(date)}.`);
                }
            }
        }));
    }
);

const funPhrase = (letter) => {
    switch (letter.toUpperCase()) {
        case 'D':
            return "D-lightful!";
        case 'E':
            return "E-lated for it.";
        case 'F':
            return "F (UN!!)";
        case 'G':
            return "G, I wonder what this could be?";
        case 'H':
            return "H (O T T O G O)";
        case 'I':
            return "I ..forgot go to make a pun."
        case 'J':
            return "J ust saw us in a tree.."
        case 'K':
            return "K (I S S I N G)"
        case 'L':
            return "L (OVE) this one!"
        case 'M':
            return "Mmmm, wonderful!"
        case 'N':
            return "N E ideas for puns? N was hard."
        case 'O':
            return "O M G!! How exciting!"
        case 'P':
            return "P on my face with excitement!"
        case 'Q':
            return "Q's in the queue.."
        case 'R':
            return "R you ready?"
        case 'S':
            return "S Club 7 declined my request so I guess you'll..."
        case 'T':
            return "T(ee) off? could we be playing golf again?"
        case 'U':
            return "U and Me?"
        case 'V':
            return "V special one this."
        case 'W':
            return "W ould you go out with me?"
        case 'X':
            return "Xylophone? 🎼 Xray? 🩻 I'm going to have to cheat on this one I think.. "
        case 'Y':
            return "Y not?"
        case 'Z':
            return "Z what I did there?"
        default:
            return `An activity has been chosen for the letter ${letter.toUpperCase()},`;
    }
}

exports.dailyTask = onSchedule(
    { schedule: "0 6 * * *", timeZone: "Europe/London", region: "europe-west1" },
    async () => {
        await checkToday();
    }
);

const checkToday = async () => {
    const snapshot = await admin.database().ref("/dates").get();
    if (!snapshot.exists()) return;

    const dates = snapshot.val();

    for (const [dateId, dateObj] of Object.entries(dates)) {
        for (const dateData of Object.values(dateObj["alphabet"])) {
            const name = dateData["name"];
            const date = dateData["date"];
            if (name && date && isToday(date)) {
                const users = await getDateUsers(dateId);
                await Promise.all(users.map(async (uid) => {
                    const fcmToken = await getFcmToken(uid);
                    if (fcmToken) {
                        await sendNotification(fcmToken, `🎉🎉 It's date day 🎉🎉`, `What are we doing? ${name}!!`);
                    }
                }));
            }
        }
    }
};

const getFcmToken = async (uid) => {
    const token = await admin.database().ref(`/users/${uid}/fcmToken`).get();
    return token.exists() ? token.val() : null;
};

const getDateUsers = async (date_id) => {
    const result = await admin.database().ref(`/dates/${date_id}/users`).get();
    return result.exists() ? Object.values(result.val() || {}) : [];
};

const sendNotification = async (fcmToken, title, body) => {
    const payload = {
        token: fcmToken,
        notification: {
            title: title,
            body: body
        }
    };
    if (recentPayloads.includes(payload)) {
        return;
    }
    recentPayloads.push(payload);
    await admin.messaging().send(payload);
};

const formatDate = (dateString) => {
    const months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];

    const addOrdinalSuffix = (day) => {
        if (day >= 11 && day <= 13) return `${day}th`; // Handle 11th, 12th, 13th
        switch (day % 10) {
            case 1: return `${day}st`;
            case 2: return `${day}nd`;
            case 3: return `${day}rd`;
            default: return `${day}th`;
        }
    };

    const [year, month, day] = dateString.split("-").map(Number);
    return `${addOrdinalSuffix(day)} ${months[month - 1]}`;
};

const isToday = (dateString) => {
    const [year, month, day] = dateString.split("-").map(Number);
    const inputDate = new Date(year, month - 1, day);
    const today = new Date();
    return (
        inputDate.getFullYear() === today.getFullYear() &&
        inputDate.getMonth() === today.getMonth() &&
        inputDate.getDate() === today.getDate()
    );
};