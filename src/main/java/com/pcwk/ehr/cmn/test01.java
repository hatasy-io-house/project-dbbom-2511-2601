package com.pcwk.ehr.cmn;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.OutputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class test01 {
    public static void main(String[] args) throws Exception {
        String apiUrl = "https://api.matgim.ai/54edkvw2hn/api-sentiment";
        String apiKey = "a767be11-fdd4-46c5-bf7a-b60df8c3ac90"; // 실제 발급받은 키로 교체
        String jsonInput = "{\"document\": \"어쩐지 아침부터 몸이 천근만근 무거웠다. 하는 일마다 자꾸 꼬이는 기분이 들어서 마음이 조급해졌고, 실수할까 봐 종일 긴장 상태였다. 사람들과 대화할 때도 괜히 날이 서 있는 내 모습이 싫어서 집에 오는 길에 한숨이 나왔다. 가끔은 아무 이유 없이 모든 게 버겁게 느껴지는 날이 있다. 오늘은 일찍 누워 복잡한 생각들을 잠시 꺼두고 싶다.\"}";

        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("x-auth-token", apiKey);
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonInput.getBytes(StandardCharsets.UTF_8));
        }

        int responseCode = conn.getResponseCode();
        System.out.println("응답 코드: " + responseCode);

        StringBuilder response = new StringBuilder();
        try (InputStream is = conn.getInputStream()) {
            byte[] buffer = new byte[1024];
            int len;
            while ((len = is.read(buffer)) != -1) {
                response.append(new String(buffer, 0, len, StandardCharsets.UTF_8));
            }
        }

        System.out.println("API 응답: " + response.toString());
    }
}