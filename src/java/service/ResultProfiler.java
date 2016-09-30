/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

/**
 *
 * @author Oleksandr
 */
public class ResultProfiler {
    int courseId;
    String courseName;
    int mark1;
    int mark2;
    String grade;

    public ResultProfiler() {
    }

    public ResultProfiler(int courseId, String courseName, int mark1, int mark2) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.mark1 = mark1;
        this.mark2 = mark2;
       // this.grade = grade;
    }


    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getMark1() {
        return mark1;
    }

    public void setMark1(int mark1) {
        this.mark1 = mark1;
    }

    public int getMark2() {
        return mark2;
    }

    public void setMark2(int mark2) {
        this.mark2 = mark2;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getGrade() {
       
        double avg =  (double)((mark1+mark2)/2); 
        if (avg < 60) {
            grade = "E";
        } else if (avg < 70) {
            grade = "D";
        } else if (avg < 80) {
            grade = "C";
        } else if (avg < 90) {
            grade = "B";
        } else {
            grade = "A";
        }
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
    
}


