package gd.fintech.lms.vo;



import java.util.List;

import lombok.Data;

@Data
public class ReportSubmit {
	private int reportSubmitNo;
	private int reportNo;
	private String accountId;
	private String reportSubmitWriter;
	private String reportSubmitCreatedate;
	private String reportSubmitUpdatedate;
	private String reportSubmitTitle;
	private String reportSubmitContent;
	private String reportSubmitPoint;
	private String reportSubmitFeedback;
	private List<ReportSubmitFile> reportSubmitFile;
	private List<Report> reportList;
}
