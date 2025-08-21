package service;

import dao.JobDAO;
import model.Job;
import util.ResumeParser;

import java.util.*;

public class ResumeMatcher {

    public static List<String> matchResume(String pdfPath) {
        Set<String> resumeSkills = ResumeParser.extractSkills(pdfPath);
        JobDAO jobDAO = new JobDAO();
        List<Job> jobs = jobDAO.getAllJobs();

        Map<String, Integer> matchScores = new HashMap<>();

        for (Job job : jobs) {
            String[] requiredSkills = job.getSkillsRequired().toLowerCase().split(",");
            int matchCount = 0;

            for (String skill : requiredSkills) {
                if (resumeSkills.contains(skill.trim())) {
                    matchCount++;
                }
            }

            int score = (int) ((matchCount / (double) requiredSkills.length) * 100);
            matchScores.put(job.getTitle(), score);
        }

        // Sort jobs by score descending
        List<Map.Entry<String, Integer>> sortedList = new ArrayList<>(matchScores.entrySet());
        sortedList.sort((a, b) -> b.getValue() - a.getValue());

        // Return top results
        List<String> bestMatches = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : sortedList) {
            bestMatches.add(entry.getKey() + " (" + entry.getValue() + "% match)");
        }

        return bestMatches;
    }

    public static void main(String[] args) {
        String resumePath = "C:\\Users\\HANEESH HASAN\\Downloads\\MyResume (13).pdf";
        List<String> matches = matchResume(resumePath);

        System.out.println("Best job matches:");
        for (String job : matches) {
            System.out.println(job);
        }
    }
}
