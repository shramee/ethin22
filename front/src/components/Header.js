import Box from '@mui/material/Box';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import {Button} from '@mui/material';
import {Link as RouterLink} from 'react-router-dom';
import {connect, disconnect} from 'get-starknet';

export default function Header() {
  return (
    <Box component="header">
      <AppBar position="relative" elevation={1} sx={{zIndex: 1}}>
        <Toolbar>
          <Typography variant="h6" sx={{flexGrow: 1}}>
            Least imperfect Governance
          </Typography>

          <Button color="inherit" edge="end" component={RouterLink} onClick={() => connect()}>
            Connect wallet
          </Button>
        </Toolbar>
      </AppBar>
    </Box>
  );
}
