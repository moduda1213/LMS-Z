package gd.fintech.lms.teacher.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gd.fintech.lms.teacher.mapper.TeacherFaqMapper;
import gd.fintech.lms.vo.Faq;
import gd.fintech.lms.vo.FaqCategory;

@Service
@Transactional
public class TeacherFaqService {
	@Autowired TeacherFaqMapper teacherFaqMapper;

	// 카테고리별 FAQ 목록 조회
	public List<Faq> getFaqListByCategory(String faqCategory, int beginRow, int rowPerPage){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("faqCategory", faqCategory);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		return teacherFaqMapper.selectFaqListByCategory(map);
	}
	
	// 카테고리별 FAQ 개수
	public int getFaqCountByCategory(String faqCategory) {
		return teacherFaqMapper.selectFaqCountByCategory(faqCategory);
	}
	
	// FAQ 카테고리 목록 조회
	public List<FaqCategory> getFaqCategoryList(){
		return teacherFaqMapper.selectFaqCategoryList();
	}
	
	// FAQ 상세보기
	public Faq getFaqOne(int faqNo) {
		return teacherFaqMapper.selectFaqOne(faqNo);
	}
	
	// FAQ 상세보기 조회 시 조회수 증가
	public int modifyFaqCount(int faqNo) {
		return teacherFaqMapper.updateFaqCount(faqNo);
	}
	
	// 검색했을 때의 FAQ 목록 조회
	public List<Faq> getFaqListBySearch(String faqCategory, String faqTitle, int beginRow, int rowPerPage){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("faqCategory", faqCategory);
		map.put("faqTitle", faqTitle);
		map.put("beginRow", beginRow);
		map.put("rowPerPage", rowPerPage);
		
		return teacherFaqMapper.selectFaqListBySearch(map);
	}
	
	// 검색했을 때의 FAQ 개수
	public int getFaqCountBySearch(String faqCategory, String faqTitle) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("faqCategory", faqCategory);
		map.put("faqTitle", faqTitle);
		
		return teacherFaqMapper.selectFaqCountBySearch(map);
	}
}
