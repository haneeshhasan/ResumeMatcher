package ui;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/JobMatchServlet")
public class JobMatchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ 1. Get extracted resume text from request
        String resumeText = (String) request.getAttribute("resumeText");

        if (resumeText == null || resumeText.isEmpty()) {
            request.setAttribute("error", "Resume text could not be extracted.");
            request.getRequestDispatcher("result.jsp").forward(request, response);
            return;
        }

        List<JobMatch> jobMatches = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/jobfinder", "root", "your_password");
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT id, title, description, skills FROM jobs")) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String skills = rs.getString("skills");

                int score = calculateMatchScore(resumeText, skills);

                jobMatches.add(new JobMatch(id, title, description, skills, score));
            }

        } catch (SQLException e) {
            throw new ServletException("DB error: " + e.getMessage(), e);
        }

        // ✅ 2. Sort by score (descending) and take top 3
        jobMatches.sort((a, b) -> Integer.compare(b.getScore(), a.getScore()));
        List<JobMatch> topMatches = jobMatches.size() > 3 ? jobMatches.subList(0, 3) : jobMatches;

        // ✅ 3. Send results to JSP
        request.setAttribute("matches", topMatches);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    // ✅ Match scoring: count how many skills appear in resume
    private int calculateMatchScore(String resumeText, String skills) {
        int score = 0;
        if (skills != null) {
            for (String skill : skills.split(",")) {
                if (resumeText.toLowerCase().contains(skill.trim().toLowerCase())) {
                    score++;
                }
            }
        }
        return score;
    }

    // ✅ Simple POJO to hold job match
    public static class JobMatch {
        private int id;
        private String title;
        private String description;
        private String skills;
        private int score;

        public JobMatch(int id, String title, String description, String skills, int score) {
            this.id = id;
            this.title = title;
            this.description = description;
            this.skills = skills;
            this.score = score;
        }

        public int getId() { return id; }
        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public String getSkills() { return skills; }
        public int getScore() { return score; }
    }
}
