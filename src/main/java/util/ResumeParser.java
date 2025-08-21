package util;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.File;
import java.util.HashSet;
import java.util.Set;

public class ResumeParser {

    public static Set<String> extractSkills(String pdfPath) {
        Set<String> skills = new HashSet<>();
        try {
            PDDocument document = PDDocument.load(new File(pdfPath));
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document).toLowerCase();
            document.close();

            // Simple skill keywords (expand later)
            String[] skillKeywords = {
                "java", "python", "sql", "javascript", "html", "css",
                "spring", "hibernate", "react", "nodejs", "selenium",
                "c", "c++", "docker", "kubernetes", "aws", "ml", "ai"
            };

            for (String skill : skillKeywords) {
                if (text.contains(skill)) {
                    skills.add(skill);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return skills;
    }
}
