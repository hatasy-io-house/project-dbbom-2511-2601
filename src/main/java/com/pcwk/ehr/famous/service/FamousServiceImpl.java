package com.pcwk.ehr.famous.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.famous.domain.FamousVO;
import com.pcwk.ehr.mapper.FamousMapper;
import com.pcwk.ehr.mapper.UserMapper;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class FamousServiceImpl implements FamousService {
	
	  final Logger log = LogManager.getLogger(getClass());

	@Autowired
	FamousMapper famousMapper;

		@Autowired
	UserMapper userMapper;
	
	@Override
	public int doUpdateRecTime(UserVO vo) {
	    // famousMapper에 새로 추가한 doUpdateRecTime을 호출합니다.
	    return famousMapper.doUpdateRecTime(vo);
	}

	@Override
	public UserVO getUserInfo(UserVO vo) {
	    // UserMapper에 이미 있는 doSelectOne을 활용합니다.
	    return (UserVO) userMapper.doSelectOne(vo);
	}
	

	@Override
	public List<FamousVO> doRetrieve(DTO dto) {
		return famousMapper.doRetrieve(dto);
	}

	@Override
	public int doUpdate(FamousVO param) {
		return famousMapper.doUpdate(param);
	}

	@Override
	public int doDelete(FamousVO param) {
		return famousMapper.doDelete(param);
	}

	@Override
	public FamousVO doSelectOne(FamousVO param) {
		return famousMapper.doSelectOne(param);
	}

	@Override
	public int doSave(FamousVO param) {
		return famousMapper.doSave(param);
	}

	@Override
	public int updateViewCount(FamousVO vo) {
	    return famousMapper.updateViewCount(vo);
	    }
	
	@Override
	public int doUpdateLike(FamousVO vo) {
	    // vo에 담긴 famousReccount 값이 -1이면 감소, 1이면 증가가 되도록
	    // Mapper의 SQL 쿼리를 활용하거나 여기서 로직을 나눕니다.
	    
	    // 1. 좋아요 수 수정 (vo에 담긴 값에 따라 +1 혹은 -1 수행)
	    famousMapper.updateReCount(vo);

	    // 2. 반영된 최신 데이터 조회
	    FamousVO latestVO = famousMapper.doSelectOne(vo);

	    // 3. 최신 좋아요 개수 반환
	    return latestVO.getFamousReccount();
	}

	@Override
	public FamousVO getFamousDetail(FamousVO vo) {
	    // 1. 상세 조회 시 조회수 증가 (기존에 만든 메서드 활용)
	    famousMapper.updateViewCount(vo); 
	    
	    // 2. 상세 데이터 가져오기
	    return famousMapper.getFamousDetail(vo);
	}
	
	@Override
	public List<FamousVO> getBest3() {
		return famousMapper.getBest3();
	}

	@Override
	public List<FamousVO> allDoRetrieve(DTO dto) {
		return famousMapper.allDoRetrieve(dto);
	}

	@Override
	public FamousVO getRandomByEmotion(String famousEmotion) {
		return famousMapper.getRandomByEmotion(famousEmotion);
	}

	@Override
	public FamousVO getById(int famousSid) {
    	return famousMapper.getById(famousSid);
}

}