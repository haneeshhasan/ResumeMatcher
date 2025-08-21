<%@ page import="java.util.List, ui.JobMatchServlet.JobMatch" %>
<%
List<JobMatch> matches = (List<JobMatch>) request.getAttribute("matches");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Job Match Results</title>
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
    padding: 40px 20px;
    color: #333;
}

.container {
    max-width: 900px;
    margin: 0 auto;
}

h2 {
    color: white;
    font-size: 2.5rem;
    text-align: center;
    margin-bottom: 40px;
    font-weight: 300;
    letter-spacing: 1px;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

h2::after {
    content: '';
    display: block;
    width: 80px;
    height: 4px;
    background: white;
    margin: 20px auto 0;
    border-radius: 2px;
    opacity: 0.8;
}

ul {
    list-style: none;
    display: grid;
    gap: 25px;
    grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
}

li {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.3);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

li::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, #667eea, #764ba2);
}

li:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
}

.job-title {
    color: #333;
    font-size: 1.4rem;
    font-weight: 600;
    margin-bottom: 15px;
    line-height: 1.3;
}

.job-description {
    color: #555;
    line-height: 1.6;
    margin-bottom: 15px;
    font-size: 0.95rem;
}

.job-skills {
    margin-bottom: 15px;
}

.job-skills strong {
    color: #667eea;
    font-weight: 600;
}

.skills-list {
    color: #666;
    background: #f8f9fa;
    padding: 10px 15px;
    border-radius: 8px;
    margin-top: 8px;
    font-size: 0.9rem;
    border-left: 3px solid #667eea;
}

.match-score {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid #eee;
}

.score-label {
    color: #333;
    font-weight: 600;
}

.score-value {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    font-weight: bold;
    font-size: 0.9rem;
    min-width: 60px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

.no-matches {
    text-align: center;
    color: white;
    font-size: 1.2rem;
    background: rgba(255, 255, 255, 0.1);
    padding: 40px;
    border-radius: 15px;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.back-button {
    position: fixed;
    top: 30px;
    left: 30px;
    background: rgba(255, 255, 255, 0.9);
    color: #667eea;
    border: none;
    padding: 12px 20px;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.back-button:hover {
    background: white;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

/* Responsive design */
@media (max-width: 768px) {
    body {
        padding: 20px 15px;
    }
    
    h2 {
        font-size: 2rem;
        margin-bottom: 30px;
    }
    
    ul {
        grid-template-columns: 1fr;
        gap: 20px;
    }
    
    li {
        padding: 25px 20px;
    }
    
    .job-title {
        font-size: 1.2rem;
    }
    
    .back-button {
        top: 20px;
        left: 20px;
        padding: 10px 16px;
        font-size: 0.9rem;
    }
}

@media (max-width: 480px) {
    .match-score {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
    }
    
    .score-value {
        align-self: flex-end;
    }
}

/* Animation for loading */
li {
    animation: slideUp 0.6s ease forwards;
    opacity: 0;
    transform: translateY(30px);
}

li:nth-child(1) { animation-delay: 0.1s; }
li:nth-child(2) { animation-delay: 0.2s; }
li:nth-child(3) { animation-delay: 0.3s; }
li:nth-child(4) { animation-delay: 0.4s; }
li:nth-child(5) { animation-delay: 0.5s; }

@keyframes slideUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</head>
<body>
<div class="container">
    <h2>Top Job Matches</h2>
    <ul>
    <% if (matches != null && !matches.isEmpty()) {
        for (JobMatch job : matches) { %>
        <li>
            <div class="job-title"><%= job.getTitle() %></div>
            <div class="job-description"><%= job.getDescription() %></div>
            <div class="job-skills">
                <strong>Skills:</strong>
                <div class="skills-list"><%= job.getSkills() %></div>
            </div>
            <div class="match-score">
                <span class="score-label">Match Score:</span>
                <span class="score-value"><%= job.getScore() %></span>
            </div>
        </li>
    <% }
    } else { %>
        <div class="no-matches">No job matches found. Please try uploading a different resume.</div>
    <% } %>
    </ul>
</div>
</body>
</html>