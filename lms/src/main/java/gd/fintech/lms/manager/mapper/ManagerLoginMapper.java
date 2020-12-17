package gd.fintech.lms.manager.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.vo.Account;
import gd.fintech.lms.vo.Address;
import gd.fintech.lms.vo.ManagerForm;

@Mapper
public interface ManagerLoginMapper {
	String selectAccountToManagerLogin(Account account);
	
	// 회원가입 할 때 추가해야하는 테이블 2개
	int insertAccountToSignup(ManagerForm managerForm);
	int insertManagerQueueToSignup(ManagerForm managerForm);
	
	// 회원가입 중복검사
	int selectAccountToSignupByOverlapId(String accountId);
	int selectManagerToSignupByOverLapEmail(String managerEmail);
	
	// 회원가입 주소검색
	List<Address> selectAddressToSearch(String doro, int currentPage, int limitPage);
	int selectAddressToSearchCount(String doro);
}
