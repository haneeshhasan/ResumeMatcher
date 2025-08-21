package ui;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

@WebServlet("/upload")
@MultipartConfig
public class ResumeUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ 1. Get uploaded file
        Part filePart = request.getPart("resume");
        String fileName = filePart.getSubmittedFileName();

        // Save uploaded file to temp folder
        File uploadFile = new File(System.getProperty("java.io.tmpdir"), fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, uploadFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        }

        // ✅ 2. Extract text from PDF
        String resumeText = extractTextFromPDF(uploadFile);

        // ✅ 3. Store resume text as request attribute
        request.setAttribute("resumeText", resumeText);

        // Forward to job matching servlet OR JSP
        request.getRequestDispatcher("JobMatchServlet").forward(request, response);
    }

    // ✅ Method to extract text from PDF
    private String extractTextFromPDF(File file) throws IOException {
        try (PDDocument document = PDDocument.load(file)) {
            PDFTextStripper stripper = new PDFTextStripper();
            return stripper.getText(document);
        }
    }
}
