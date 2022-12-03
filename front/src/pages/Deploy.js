import {Typography, TextField, Grid, Item} from '@mui/material';

export default function Deploy() {
  return (
    <div>
      <Typography>Prepare quiz</Typography>
      <Grid fixed container spacing={2}>
        {new Array(5).fill(0).map((e, i) => (
          <Grid fixed container item xl={6} spacing={2}>
            <Grid item xs={6}>
              <h4>Question {i + 1}</h4>
              <TextField fullWidth margin="normal" label="Question title" variant="outlined" />
            </Grid>
            <Grid item xs={6}>
              <TextField fullWidth multiline margin="normal" label="Question options" variant="outlined" rows={4} />
            </Grid>
          </Grid>
        ))}
      </Grid>
    </div>
  );
}
