package gd.fintech.lms.vo;

import java.util.List;

import lombok.Data;

@Data
public class LectureArchive {
	private int lectureArchiveNo;
	private int lectureNo;
	private String accountId;
	private String lectureArchiveWriter;
	private String lectureArchiveTitle;
	private String lectureArchiveContent;
	private String lectureArchiveCreatedate;
	private String lectureArchiveUpdatedate;
	private int lectureArchiveCount;
	private Lecture lecture;
	private Subject subject;
	private List<ClassRegistration> classRegistrationList;
	private List<LectureArchiveFile> lectureArchiveFileList;
}
