package gd.fintech.lms.manager.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.vo.Classroom;
import gd.fintech.lms.vo.Lecture;
import gd.fintech.lms.vo.Subject;
import gd.fintech.lms.vo.Syllabus;
import gd.fintech.lms.vo.Teacher;
import gd.fintech.lms.vo.Textbook;

@Mapper
public interface ManagerLectureMapper {
	//강좌 목록을 불러오기 위해 연결해주는 메퍼
	List<Lecture> selectLectureList();
	//강사 리스트를 불러오기 위해 연결해주는 메퍼
	List<Teacher> selectTeacherList();
	//과목 리스트를 불러오기 위해 연결해주는 메퍼
	List<Subject> selectSubjectList();
	//교재 리스트를 불러오기 위해 연결해주는 메퍼
	List<Textbook> selectTextbookList();
	//강의계획서 리스트를 불러오기 위해 연결해주는 메퍼
	List<Syllabus> selectSyllabusList();
	//강의실 리스트를 불러오기 위해 연결해주는 메퍼
	List<Classroom> selectClassroomList();
	//강좌 등록정보를 강좌목록에 추가하기위해 연결하는 메퍼
	int insertLecture(Lecture lecture);
}
