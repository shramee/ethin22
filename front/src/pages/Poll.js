import React, {Component, useState} from 'react';
import {Button} from '@mui/material';
import {create} from 'ipfs-core';

const mockData = [
  'Qmdi1pBKGtYMgzTevViWh1ijXGrCZ3rQmBWqBeohhZvneV',
  'QmdCssf9FNbqaGtsyXVB59cFfdTWvgNorh7qPTZPsBe8AQ',
  'QmTLRPxewaaxsqy1jSUCLEWt16mNCSVVhNq3SdSqrDVzh1',
  'Qmc1z7MBQGZMiTUJnFmdDo62vocrELiSeHeL4jtrUeTgoW',
];

export default function Poll() {
  const [questions, setQuestion] = useState( [{
    "question": "Which NFT protocol is best for designations around the country?",
    "options": ["ERC721", "ERC1155", "Dave's ERC721 fork"]
  }] );
  mockData.forEach( async poll => {
    const ipfs = await create();
    const poll_data = ipfs.cat(poll);
    console.log( poll_data );
  } );
  return <div>
    <h1>Polls</h1>

    {questions.map( poll => <div>
      {poll.question}
      {poll.options.map( op => <Button fullWidth style={{marginRight: 'auto', }}>{op}</Button> )}
    </div>)}
  </div>;
}
