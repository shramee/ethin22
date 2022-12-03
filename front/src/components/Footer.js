import {Paper, Typography} from '@mui/material';

export default function Footer(props) {
  return (
    <Paper square variant="outlined" component="footer" {...props}>
      <Typography>Least imperfect Governance &copy; {new Date().getFullYear()}</Typography>
    </Paper>
  );
}
