package gd.fintech.lms.manager.restservice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gd.fintech.lms.manager.restmapper.LmsStatsRestMapper;

@Service
@Transactional
public class LmsStatsRestService {
	@Autowired LmsStatsRestMapper lmsStatsRestMapper;
	//연도별 강사 가입 수 / 탈퇴 수를 구하기 위한 메퍼 호출
	public List<Map<String, Object>> getTeacherInOutCount(){
		return lmsStatsRestMapper.selectTeacherInOutCount();
	}
	//연도별 강사 가입 수 / 탈퇴 수를 구하기 위한 메퍼 호출
	public List<Map<String, Object>> getStudentInOutCount(){
		return lmsStatsRestMapper.selectStudentInOutCount();
	}
	//전체 강사와 학생의 수를 구하기 위한 메퍼 호출
	public Map<String, Object> getTeacherAndStudentCount(){
		return lmsStatsRestMapper.selectTeacherAndStudentCount();
	}
}
