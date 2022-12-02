import * as React from 'react';
import {
	Avatar, Button, CssBaseline, TextField, FormControlLabel, Checkbox, Link, Grid, Box, Typography, Container,
} from '@mui/material';
import {Link as RouterLink} from 'react-router-dom';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';

export default function SignIn() {
	const handleSubmit = ( event ) => {
		event.preventDefault();
		const data = new FormData( event.currentTarget );
		console.log( {
			email: data.get( 'email' ), password: data.get( 'password' ),
		} );
	};

	return <Container component="main" maxWidth="xs">
		<CssBaseline/>
		<Box
			sx={{
				marginTop: 8, display: 'flex', flexDirection: 'column', alignItems: 'center',
			}}
		>
			<Avatar sx={{m: 1, bgcolor: 'secondary.main'}}>
				<LockOutlinedIcon/>
			</Avatar>
			<Typography component="h1" variant="h5">
				Sign in
			</Typography>
			<Box component="form" onSubmit={handleSubmit} noValidate sx={{mt: 1}}>
				<Grid container spacing={2}>
					<Grid item xs={12}>
						<TextField
							required
							fullWidth
							id="email"
							label="Email Address"
							name="email"
							autoComplete="email"
							autoFocus
						/>
					</Grid>
					<Grid item xs={12}>
						<TextField
							required
							fullWidth
							name="password"
							label="Password"
							type="password"
							id="password"
							autoComplete="current-password"
						/>
					</Grid>
					<Grid item xs={12}>
						<FormControlLabel
							control={<Checkbox value="remember" color="primary"/>}
							label="Remember me"
						/>
					</Grid>
					<Grid item xs={12}>
						<Button type="submit" fullWidth variant="contained">
							Sign In
						</Button>
					</Grid>
					<Grid item xs>
						<Link href="#" variant="body2">
							Forgot password?
						</Link>
					</Grid>
					<Grid item>
						<Link component={RouterLink} to="/signup" variant="body2">
							{"Don't have an account? Sign Up"}
						</Link>
					</Grid>
				</Grid>
			</Box>
		</Box>
	</Container>;
}