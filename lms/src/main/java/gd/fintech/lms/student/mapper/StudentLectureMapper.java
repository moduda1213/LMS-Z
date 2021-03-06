package gd.fintech.lms.student.mapper;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.vo.ClassRegistration;
import gd.fintech.lms.vo.ClassRegistrationCancel;
import gd.fintech.lms.vo.ClassRegistrationForm;
import gd.fintech.lms.vo.Lecture;

@Mapper
public interface StudentLectureMapper {
	// 페이징) 전체 강의 목록 map => beginRow, rowPerPage
	public List<Lecture> selectLectureList(Map<String, Object> map);
	
	// 페이징) 전체 강의목록 갯수
	public int selectLectureListTotal();
	
	//****  강의 목록 상세보기 ******
	public Lecture selectLectureListOne(int lectureNo);
	
	//=====강의 정원 체크 (값이 있다면 true,없다면 false줄 예정) 중복신청방지  ======
	public int selectCanIApplicant(Map<String,Object> map);
	
	// ==== 강의 신청 여부 체크 ====
	public int selectClassRegistrationCk(Map<String,Object> map);
	
	// ==== 강의 신청 인원 ===
	public int selectNumberOfApplicants(int lectureNo);
	
	//===== 강의 수강 신청 ====
	public int insertClassRegistration(Map<String,Object> map);
	
	//==== 페이징)나의 수강 현황 목록 =========
	public List<ClassRegistration> selectMyLectureList(Map<String,Object> map);
	
	//==== 페이징)전체 나의 수강 현황 목록 수 =====
	public int selectMyLectureListTotal(String studentId);
	
	//==== 날짜 종료 시 성적에 따른 과락,수료 업데이트 ====
	public int updateMyLectureState(Map<String,Object> map);
	
	//==== 나의 수강 현황 상세보기 ====
	public ClassRegistrationForm selectMyLectureListOne(Map<String,Object> map);
	
	//==== 수료한 수강생들만 사용할 수 있는 수강 후기 작성 =====
	public int updateLectureReview(ClassRegistration classRegistration);
	
	//=== 승인 대기중인 강의 취소 ====
	public int deleteWaitingClassCancel(int classRegistrationNo);
	
	//=== 수강 중 취소한 사유 저장 ====
	public int insertReasonForCancellation(ClassRegistrationCancel classRegistrationCancel);
	
	//=== 수강 중 취소시 상태 변화 / 수강중 -> 취소
	public int updateClassStateChange(int classRegistrationNo);
	
	//강좌 삭제를 위한 수강취소한 목록 삭제
	public int deleteClassRegistrationCancel(int classRegistrationNo);
	
	//==== 과락, 수료 처리하기 위한 날짜 종료일 구분 ==
	public int selectLectureEnddate(int lectureNo);
	
	//=== 해당 강의 과제 평균 점수 ====
	public int selectReportAvg(Map<String,Object> map);
}