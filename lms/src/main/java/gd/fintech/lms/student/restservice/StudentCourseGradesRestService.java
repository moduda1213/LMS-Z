package gd.fintech.lms.student.restservice;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gd.fintech.lms.student.restmapper.StudentCourseGradesRestMapper;

@Service
@Transactional
public class StudentCourseGradesRestService {
	@Autowired StudentCourseGradesRestMapper studentCourseGradesRestMapper;
	
	//강의별 성적 및 강의 평균 성적 가져오기
	public Map<String,Object> getCouresGrades(String studentId){
		return studentCourseGradesRestMapper.selectCourseGreads(studentId);
	}
	
}