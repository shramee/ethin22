import Box from '@mui/material/Box';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import {Button} from '@mui/material';
import {Wallet} from '@mui/icons-material';
import {connect, disconnect} from 'get-starknet';
import {useState} from 'react';

export default function Header() {
  const [wallet, setWallet] = useState( '' );
  connect( {showList: false} ).then( wallet => {
    wallet?.enable( {showModal: true} ).then( () => {
      console.log( wallet );
      setWallet( wallet.selectedAddress )
    } );
  } );

  return (
    <Box component='header'>
      <AppBar position='relative' elevation={1} sx={{zIndex: 1}}>
        <Toolbar>
          <Typography variant='h6' sx={{flexGrow: 1}}>
            Least imperfect Governance
          </Typography>

          <Button color="inherit" edge="end" onClick={() => disconnect()}>
            <Wallet />
            ...{wallet.slice( -6 )}
          </Button>
        </Toolbar>
      </AppBar>
    </Box>
  );
}
