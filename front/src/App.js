import Header from './components/Header';
import Sidebar from './components/Sidebar';
import Footer from './components/Footer';
import {Outlet} from 'react-router-dom';
import Box from '@mui/material/Box';
import {useState} from 'react';
import {Button, Stack} from '@mui/material';
import {connect} from 'get-starknet';

const DEFAULT_DRAWER_OPEN = true;
const STORAGE_DRAWER_OPEN = window.localStorage.getItem( '__userDidDrawerOpen' );

export default function App() {

  const userDidDrawerOpen = STORAGE_DRAWER_OPEN ? STORAGE_DRAWER_OPEN === 'true' : DEFAULT_DRAWER_OPEN;

  const [walletConnected, setWalletConnected] = useState( false );
  const [drawerOpen, _drawerToggle] = useState( userDidDrawerOpen );
  const drawerToggle = e => {
    window.localStorage.setItem( '__userDidDrawerOpen', e );
    _drawerToggle( e );
  };

  connect({showList: false}).then( wallet => {
    wallet?.enable( {showModal: true} ).then( () => setWalletConnected( wallet.isConnected ) )
  }
  )
  const
    drawerWidthEx    = 200,
    drawerWidthCmp   = 56,
    drawerWidth      = drawerOpen ? drawerWidthEx : drawerWidthCmp,
    drawerTransition = {transitionDuration: '.3s', transitionTimingFunction: '', transitionProperty: 'margin'},
    drawerProps      = {
      drawerOpen, drawerToggle, drawerWidthEx, drawerWidth, drawerWidthCmp, drawerTransition,
    },
    sxMainLayout         = {overflow: 'auto', p: 3, flexGrow: 1, display: 'flex', flexDirection: 'column'};
  return (
    <Stack sx={{height: '100vh'}}>
      <Header {...drawerProps} />
      <Sidebar {...drawerProps} />
      <Box component='main' sx={{...sxMainLayout, ml: drawerWidth + 'px', ...drawerTransition}}>
        {walletConnected ?
          <Outlet /> :
          <Button sx={{margin: '3em auto auto', fontSize: '1.6em'}} variant='contained' size='large'
                  onClick={() => connect().then( wallet =>
                    wallet?.enable( {showModal: true} ).then( () => setWalletConnected( wallet ) ) )}>
            Connect wallet</Button>}
      </Box>
      <Footer sx={{ml: drawerWidth + 'px', ...drawerTransition, py: 1, px: 3}} />
    </Stack>
  );
};
