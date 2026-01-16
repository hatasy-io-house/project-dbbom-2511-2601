package com.pcwk.ehr.notice.noticeService;

import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pcwk.ehr.mapper.NoticeMapper;
import com.pcwk.ehr.notice.domain.NoticeVO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
    
    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public int doSave(NoticeVO inVO) {
        return noticeMapper.doSave(inVO);
    }

    @Override
    public int doUpdate(NoticeVO inVO) {
        return noticeMapper.doUpdate(inVO);
    }

    @Override
    public int doDelete(NoticeVO inVO) {
        return noticeMapper.doDelete(inVO);
    }

    @Override
    public NoticeVO doSelectOne(NoticeVO inVO) {
        return noticeMapper.doSelectOne(inVO);
    }

    @Override
    public List<NoticeVO> doRetrieve(NoticeVO inVO) {
        return noticeMapper.doRetrieve(inVO);
    }
}