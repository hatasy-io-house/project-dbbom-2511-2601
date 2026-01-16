package com.pcwk.ehr.report.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.mapper.ReportMapper;
import com.pcwk.ehr.report.domain.ReportVO;
import com.pcwk.ehr.cmn.DTO;
import java.util.List;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    ReportMapper reportMapper;

    @Override
    public int doSave(ReportVO param) {
        return reportMapper.doSave(param);
    }

    @Override
    public int doDelete(ReportVO param) {
        return reportMapper.doDelete(param);
    }

    @Override
    public int doUpdate(ReportVO param) {
        return reportMapper.doUpdate(param);
    }

    @Override
    public ReportVO doSelectOne(ReportVO param) {
        return reportMapper.doSelectOne(param);
    }

    @Override
    public List<ReportVO> doRetrieve(DTO dto) {
        return reportMapper.doRetrieve(dto);
    }
    
}
