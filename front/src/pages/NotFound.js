import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";

export default function NotFound() {
	return <Box sx={{textAlign: 'center'}}>
		<Typography variant="h2" sx={{mt: '20vh', mb: 4}}>Not found</Typography>
		<Typography variant="body1">Looks like this page doesn't exist.</Typography>
	</Box>

};