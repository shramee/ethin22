### Eth India 2022 contracts

# Least imperfect Governance

Least imperfect Governance includes contracts for decentralizing the a specific ministry of an area. There's no minister or to say it's replaced by the contract and the voters.

## Problems with democracy

> A tiny percentage of people making decisions for the masses

A miniscule percentage of the population makes the decisions for the whole country. This allows others the opportunity to incentivise these handful of people to make favorable decisions for them. If the number of people actually participating in the decision making was far greater, say around 1%. This would be much harder.

> Half the people choosing the person to lead are below average intelligence.

Try to imagine how low the average intelligence is, now imagine the 50% of the population under it. Devastating isn't it? Our livelihoods are basically in hands of entities these people choose for us.

## Solutions

The ministries each have a contract which automated [registration](#how-are-users-registered-to-participate-in-governance) based on a simple criteria. There's no concept of citizenship. Location contract that tracks where the people live. Anybody can join the ministry.

The challenge of competence of participating voters is met with a basic quiz covering prerequisites to be able to govern effectively.

## Challenges

Having the quiz was really complicated, we want to be able to check the quizzes online but it was challenging because the number of possibilities of input wouldn't be infinite and it'd be possible to try the combinations. Adding a salt wouldn't work either because salt can not be stored privately.

### Using VDF (Verifiable Delay Function)

We start with a secure random salt and use it to hash the solution. This salt is then passed through a VD function before it’s saved on chain. Making it really expensive to calculate backwards.

This keeps the solution safe for a while until VDF’s delay is exceeded. Because of the nature of quiz staying up for long periods of time this is not viable. Not to mention we need to delegate computation resources for the entire delay period to check the results.

Remnants of the code for this can be found in `contracts/src/vdf`

### Solving with privately held salts

First member of the contract submits a quiz, the solution to the quiz is hashed with a private salt which is never saved on chain.

The applicants keep solving and their solutions are saved as jobs for later resolution, at a later point the original quiz master (ideally an expert in the field) periodically sends their private salt to the chain help evaluate the pending jobs for evaluating applicants.

To promote decentralization in this approach multiple quiz masters can participate, participants can be assigned a new test from another expert in case the original poster is not available to provide the solution salt in an acceptable timeframe.

One of my very educated friends tell me that this is what is referred to as **commitment schemes**.

This part is a work in progress.

---

## FAQ

> How are users registered to participate in governance?

Any wallet owner that meets these two criteria is accepted as a voter,

1. Calls [Location contract](#location-contract) to confirm voter's lives in the location being governed. If you live in an area you get to participate in the governance.
2. Uses a small quiz to assert if the voter has basic understanding of the concepts of ministry.

> How is the quiz for the ministry determined?

For now, an IPFS file location is passed in constructor. Down the road they'd be voted upon.

> How are the questions...

IPFS, IPFS everywhere. Question ID is the IPFS file hash. A question in all honesty, is essentially this hash, number of options in the question.

---

## Main contract

Handles actual voting, registering and actions for voters. One contract handles governing of a specific geographic location and only a specific ministry.

## Location contract

Tracks where the user is based on the globe. This is macking the functionality while keeping the signature essentially.
