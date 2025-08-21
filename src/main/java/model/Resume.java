package model;

import java.util.List;

public class Resume {
    private int id;
    private String name;
    private List<String> skills;

    public Resume(String name, List<String> skills) {
        this.name = name;
        this.skills = skills;
    }

    public List<String> getSkills() {
        return skills;
    }

    public String getName() {
        return name;
    }
}
