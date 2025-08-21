package model;

public class Job {
    private int id;
    private String title;
    private String skillsRequired;

    public Job() {}

    public Job(String title, String skillsRequired) {
        this.title = title;
        this.skillsRequired = skillsRequired;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getSkillsRequired() {
        return skillsRequired;
    }
    public void setSkillsRequired(String skillsRequired) {
        this.skillsRequired = skillsRequired;
    }

    @Override
    public String toString() {
        return "Job [id=" + id + ", title=" + title + ", skills=" + skillsRequired + "]";
    }
}
