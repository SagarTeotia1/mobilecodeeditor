const express = require('express');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const app = express();
const port = process.env.PORT || 3000;

// Replace this with your actual Gemini API key
const GEMINI_API_KEY = "AIzaSyDl-Oyrwp74xe1Xr9lqfAgxC-cIHqsDu1M";

const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);

app.use(express.json());

app.post('/generate-question', async (req, res) => {
  const { language } = req.body;
  
  try {
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    
    const prompt = `Generate a coding question for ${language} programming language. The question should be suitable for practice and not too complex.`;
    
    const result = await model.generateContent(prompt);
    const question = result.response.text();
    
    res.json({ question });
  } catch (error) {
    console.error('Error generating question:', error);
    res.status(500).json({ error: 'Failed to generate question' });
  }
});

app.post('/run-code', async (req, res) => {
  const { language, code, question } = req.body;
  
  try {
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    
    const prompt = `
      Language: ${language}
      Question: ${question}
      Code: ${code}
      
      Evaluate the code above and provide:
      1. The output of the code
      2. A rank from 1 to 10 based on code correctness and efficiency
      3. Brief feedback on the code
      
      Format the response as JSON with keys: output, rank, feedback
    `;
    
    const result = await model.generateContent(prompt);
    const evaluation = JSON.parse(result.response.text());
    
    res.json(evaluation);
  } catch (error) {
    console.error('Error running code:', error);
    res.status(500).json({ error: 'Failed to run code' });
  }
});

app.post('/submit-question', async (req, res) => {
  const { language, question } = req.body;
  
  try {
    const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
    
    const prompt = `
      Provide a helpful answer to the following ${language} programming question:
      ${question}
    `;
    
    const result = await model.generateContent(prompt);
    const answer = result.response.text();
    
    // In a real application, you might want to store the question and answer in a database
    console.log(`Question: ${question}`);
    console.log(`Answer: ${answer}`);
    
    res.json({ message: 'Question submitted successfully' });
  } catch (error) {
    console.error('Error submitting question:', error);
    res.status(500).json({ error: 'Failed to submit question' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});