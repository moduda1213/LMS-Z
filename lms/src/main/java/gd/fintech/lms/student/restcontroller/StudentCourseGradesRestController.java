package gd.fintech.lms.student.restcontroller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import gd.fintech.lms.student.restservice.StudentCourseGradesRestService;
import gd.fintech.lms.vo.ClassRegistration;

@RestController
public class StudentCourseGradesRestController {
	@Autowired StudentCourseGradesRestService studentCourseGradesRestService;
	
	//강의별 성적 및 평균 성적 view에 전달
	@GetMapping("/chart/studentCourseGrades/{studentId}")
	public Map<String,Object> studentCouresGrades(
			@PathVariable(name="studentId") String studentId){
		
		Map<String,Object> map= new HashMap<>();
		map.put("lectureName",studentCourseGradesRestService.getLectureName(studentId));
		map.put("score", studentCourseGradesRestService.getScore(studentId));
		map.put("scoreAvg", studentCourseGradesRestService.getScoreAvg(studentId));
		
		return map;
	}
}
