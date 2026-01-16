package com.pcwk.ehr.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.user.domain.UserVO;

@Mapper
public interface AdminMapper {
	List<UserVO> doRetrieveUserList(DTO dto);

	List<DiaryVO> doRetrieveDiaryList(DTO dto);

	List<ReportVO> doRetrieveReportList(DTO dto);

	// 4. 게시글 상태 변경
	int doUpdateDiaryStatus(DiaryVO vo);

	int getReportTotalCount(DTO dto);

	int getUserTotalCount(DTO dto);

	int getDiaryTotalCount(DTO dto);

	int doDeleteUser(UserVO vo);

	int doDeleteReport(ReportVO vo);

	int doDeleteDiary(DiaryVO vo);

	int doDeleteComment(ReportVO vo);
}