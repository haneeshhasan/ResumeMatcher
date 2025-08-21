<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Finder</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    padding: 40px;
    max-width: 500px;
    width: 100%;
    text-align: center;
    border: 1px solid rgba(255, 255, 255, 0.2);
}

h2 {
    color: #333;
    font-size: 2rem;
    margin-bottom: 30px;
    font-weight: 300;
    letter-spacing: 1px;
}

h2::after {
    content: '';
    display: block;
    width: 60px;
    height: 3px;
    background: linear-gradient(90deg, #667eea, #764ba2);
    margin: 15px auto 0;
    border-radius: 2px;
}

form {
    display: flex;
    flex-direction: column;
    gap: 25px;
    align-items: center;
}

.file-input-container {
    position: relative;
    display: inline-block;
    width: 100%;
    max-width: 320px;
}

label {
    display: block;
    font-size: 1.1rem;
    color: #555;
    margin-bottom: 15px;
    font-weight: 500;
}

.file-input-wrapper {
    position: relative;
    overflow: hidden;
    display: inline-block;
    width: 100%;
}

input[type="file"] {
    position: absolute;
    left: -9999px;
    opacity: 0;
}

.file-input-label {
    display: block;
    padding: 15px 25px;
    background: #f8f9fa;
    border: 2px dashed #667eea;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.3s ease;
    color: #667eea;
    font-weight: 500;
    margin-bottom: 0;
}

.file-input-label:hover {
    background: #667eea;
    color: white;
    border-color: #667eea;
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.file-input-label::before {
    content: "📄";
    display: inline-block;
    margin-right: 10px;
    font-size: 1.2rem;
}

button {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 15px 35px;
    font-size: 1.1rem;
    font-weight: 600;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
    letter-spacing: 0.5px;
    text-transform: uppercase;
    min-width: 200px;
}

button:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 30px rgba(102, 126, 234, 0.4);
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
}

button:active {
    transform: translateY(-1px);
}

/* Responsive design */
@media (max-width: 600px) {
    .container {
        padding: 30px 20px;
        margin: 10px;
    }
    
    h2 {
        font-size: 1.6rem;
    }
    
    .file-input-label {
        padding: 12px 20px;
        font-size: 0.95rem;
    }
    
    button {
        padding: 12px 30px;
        font-size: 1rem;
        min-width: 180px;
    }
}

/* Loading animation for button */
button:disabled {
    opacity: 0.7;
    cursor: not-allowed;
}

/* Focus styles for accessibility */
input[type="file"]:focus + .file-input-label,
button:focus {
    outline: 2px solid #667eea;
    outline-offset: 2px;
}

/* Smooth animations */
* {
    transition: all 0.2s ease;
}
</style>
</head>
<body>
<div class="container">
    <h2>Upload Your Resume</h2>
    <form action="upload" method="post" enctype="multipart/form-data">
        <div class="file-input-container">
            <label>Select Resume (PDF):</label>
            <div class="file-input-wrapper">
                <input type="file" name="resume" id="resume" required>
                <label for="resume" class="file-input-label">Choose PDF File</label>
            </div>
        </div>
        <button type="submit">Find Matching Jobs</button>
    </form>
</div>
</body>
</html>