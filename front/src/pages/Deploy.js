import {useState} from 'react';
import {Typography, TextField, Grid, Item, Button, Select} from '@mui/material';

function handleSubmit( e ) {
  e.preventDefault();
//  const form = e.currentTarget;
  const form = e.target;
  const formData = new FormData(form);

  console.log( formData );

  console.log( e );
}

export default function Deploy() {
  const [questionCount, setQuestionCount] = useState(5);
  return (
    <form onSubmit={e => handleSubmit( e ) }>
      <Grid fixed container spacing={3}>
        <Grid item xs={12}>
          <h1>Deployment steps</h1>
          <h2>
            1. Prepare qualifier quiz.

            <select style={{padding: '.5em', verticalAlign: 'middle', marginLeft: '1em'}}
                    required onChange={e => setQuestionCount( +e.target.value )} value={questionCount}>
              {new Array(10).fill(0).map( (e, i) => <option value={i + 1}>{i + 1} questions</option> )}
            </select>

            <Button type='submit' required sx={{float:'right'}} variant="contained">
              Next
            </Button>

          </h2>
        </Grid>
        {new Array(questionCount).fill(0).map((e, i) => (
          <Grid fixed container item xl={4} lg={6} spacing={3}>
            <Grid item xs={12}>
              <h4>Question {i + 1}</h4>
            </Grid>
            <Grid item xs={12}>
              <TextField name={`q${i}[question]`} required fullWidth label="Question title" variant="outlined" />
            </Grid>
            <Grid item xs={12}>
              <TextField name={`q${i}[choices]`} required fullWidth multiline label="Question options"
                         variant="outlined" rows={4} helperText='One option per line' />
            </Grid>
          </Grid>
        ))}
      </Grid>
    </form>
  );
}
