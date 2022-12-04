import React from 'react';
import {Box, Drawer, List as MuiList, ListItemButton, ListItemIcon, ListItemText, Stack} from '@mui/material';
import {AddCircle, RocketLaunch, CheckCircle} from '@mui/icons-material';
import {ExpandCircleDownOutlined} from '@mui/icons-material';
import {useNavigate} from 'react-router-dom';

/**
 * Renders sidebar item
 * @param {React.ReactElement} Icon
 * @param {string} label
 * @param {callback} onClick
 * @param {string} to
 * @returns {JSX.Element}
 */
export function SidebarBtn({Icon, label, onClick, to}) {
  const navigate = useNavigate();

  const onClickFunc = e => {
    typeof to === 'string' && navigate(to);
    typeof onClick === 'function' && onClick(e);
  };

  const icon = React.isValidElement(Icon) ? Icon : <Icon />;

  return (
    <ListItemButton onClick={onClickFunc}>
      <ListItemIcon sx={{minWidth: 42}}>{icon}</ListItemIcon>
      {<ListItemText primary={label} />}
    </ListItemButton>
  );
}

/** Sidebar component */
export default function Sidebar({drawerOpen, drawerToggle, drawerTransition, drawerWidth, drawerWidthEx}) {
  function List({...props}) {
    props.sx = props.sx ? props.sx : {};
    props.sx.width = drawerWidthEx;
    return <MuiList {...props} />;
  }

  return (
    <Drawer hideBackdrop={true} open={drawerOpen} variant="permanent" PaperProps={{sx: {zIndex: 0}}}>
      <Box component="nav" sx={{bgcolor: 'primary', height: '64px'}} />
      <Stack sx={{flex: 1, width: drawerWidth, overflow: 'hidden', ...drawerTransition, transitionProperty: 'width'}}>
        <List sx={{overflow: 'auto'}}>
          <SidebarBtn Icon={CheckCircle} label={'Polls'} to="/" />
          <SidebarBtn Icon={AddCircle} label={'Add poll'} to="/new" />
          {/*<SidebarBtn Icon={RocketLaunch} label={'Deploy account'} to="/deploy" />*/}
        </List>

        <List sx={{mt: 'auto'}}>
          <SidebarBtn
            Icon={<ExpandCircleDownOutlined sx={{transform: `rotate(${drawerOpen ? '' : '-'}90deg)`}} />}
            label={drawerOpen ? 'Collapse' : '\u00A0'}
            onClick={e => drawerToggle(!drawerOpen)}
          />
        </List>
      </Stack>
    </Drawer>
  );
}
