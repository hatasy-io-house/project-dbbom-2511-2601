package com.pcwk.ehr.diary.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.diary.domain.DiaryVO;
import com.pcwk.ehr.mapper.DiaryMapper;
import com.pcwk.ehr.famous.domain.FamousVO;

@Service
public class DiaryServiceImpl implements DiaryService 
{
    final Logger log = LogManager.getLogger(getClass());

    @Autowired
    DiaryMapper diaryMapper;
    
    @org.springframework.beans.factory.annotation.Autowired
    com.pcwk.ehr.famous.service.FamousService famousService;

    /**
     * 다이어리 내용으로 감정분석 후, 감정(P/N)에 맞는 랜덤 명언 반환
     */
    // @Override
    // public FamousVO assignFamousBySentiment(DiaryVO diary) {
    //     String apiUrl = "https://api.matgim.ai/54edkvw2hn/api-sentiment";
    //     String apiKey = "";  // 여기에 실제 API 키를 입력하세요!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //     String diaryContent = diary.getDiaryContent();
    //     String jsonInput = String.format("{\"document\": \"%s\"}", diaryContent.replace("\"", "\\\""));
    //     String sentimentResult = "N"; // 기본값: 부정
    //     String apiResponse = "";
    //     try {
    //         java.net.URL url = new java.net.URL(apiUrl);
    //         java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
    //         conn.setRequestMethod("POST");
    //         conn.setRequestProperty("Content-Type", "application/json");
    //         conn.setRequestProperty("x-auth-token", apiKey);
    //         conn.setDoOutput(true);
    //         try (java.io.OutputStream os = conn.getOutputStream()) {
    //             os.write(jsonInput.getBytes(java.nio.charset.StandardCharsets.UTF_8));
    //         }
    //         int responseCode = conn.getResponseCode();
    //         StringBuilder response = new StringBuilder();
    //         try (java.io.InputStream is = conn.getInputStream()) {
    //             byte[] buffer = new byte[1024];
    //             int len;
    //             while ((len = is.read(buffer)) != -1) {
    //                 response.append(new String(buffer, 0, len, java.nio.charset.StandardCharsets.UTF_8));
    //             }
    //         }
    //         apiResponse = response.toString();
    //         log.info("감정분석 API 응답: " + apiResponse);
    //             // document_score.score 값 기준으로 판별
    //             double score = 0.0;
    //             try {
    //                 int docScoreIdx = apiResponse.indexOf("\"document_score\"");
    //                 if (docScoreIdx != -1) {
    //                     int scoreIdx = apiResponse.indexOf("\"score\":", docScoreIdx);
    //                     if (scoreIdx != -1) {
    //                         int commaIdx = apiResponse.indexOf(',', scoreIdx);
    //                         String scoreStr = apiResponse.substring(scoreIdx + 8, commaIdx).trim();
    //                         score = Double.parseDouble(scoreStr);
    //                         log.debug("[[[[[[[[[[[[[[[파싱된 score: " + score);
    //                         sentimentResult = score >= 0 ? "P" : "N";
    //                     }
    //                 }
    //             } catch (Exception parseEx) {
    //                 log.error("score 파싱 오류", parseEx);
    //                 sentimentResult = "N";
    //         }
    //     } catch (Exception e) {
    //         log.error("감정분석 API 호출 오류", e);
    //         log.debug("-----------------------------------------------------------");
    //         sentimentResult = "N";
    //     }
    //     return famousService.getRandomByEmotion(sentimentResult);
    // }


    @Override
    public FamousVO assignFamousBySentiment(DiaryVO diary) {
        // 테스트용: API 호출 없이 임의의 score 값 사용
        double score = -0.5; // 임의의 값, 필요시 변경
        log.info("테스트용 score: " + score);
        String sentimentResult = score >= 0 ? "P" : "N";
        return famousService.getRandomByEmotion(sentimentResult);
    }

    public DiaryVO upDoSelectOne(DiaryVO param) {
        log.debug("┌---------------------------┐");
        log.debug("│upDoSelectOne param: " + param);  
        log.debug("└---------------------------┘");

        int flag = diaryMapper.updateViewCount(param);
        log.debug("flag : " + flag);
        DiaryVO diaryVO =  diaryMapper.doSelectOne(param);

        return diaryVO;


    }

    @Override
    public List<DiaryVO> doRetrieve(DTO dto) {
        return diaryMapper.doRetrieve(dto);
    }

    @Override
    public int doUpdate(DiaryVO param) {
        return diaryMapper.doUpdate(param);
    }

    @Override
    public int doDelete(DiaryVO param) {
        return diaryMapper.doDelete(param);
    }

    @Override
    public DiaryVO doSelectOne(DiaryVO param) {
        return diaryMapper.doSelectOne(param);
    }

    @Override
    public int doSave(DiaryVO param) {
        return diaryMapper.doSave(param);
    }

    @Override
    public List<DiaryVO> doPublicRetrieve(DTO dto) {
        return diaryMapper.doPublicRetrieve(dto);
    }

    @Override
    public List<DiaryVO> getBest3() {
        return diaryMapper.getBest3();
    }   

    @Override
    public int updateRecCount(DiaryVO param) {
        return diaryMapper.updateRecCount(param);
    }


        @Override
    public int getDiaryCount(DiaryVO param) {
        return diaryMapper.getDiaryCount(param);
    }

    @Override
    public int getMonthDiaryCount(DiaryVO param) {
        return diaryMapper.getMonthDiaryCount(param);
    }
    
    @Override
    public int getUserTotalCount(DiaryVO param) {
        return diaryMapper.getUserTotalCount(param);
    }

    @Override
    public int getUserMonthCount(DiaryVO param) {
        return diaryMapper.getUserMonthCount(param);
    }
    
    @Override
    public List<DiaryVO> selectMonthDiary(DiaryVO param) {
        return diaryMapper.selectMonthDiary(param);
    }
}