package com.steamcentral.core.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public interface HttpConnection {

	default String getHttpContent(String url) {
		try {
			HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0");
			int responseCode = connection.getResponseCode();
			InputStream is;
			
			if(200 <= responseCode && responseCode <= 299) {
				is = connection.getInputStream();
			} else if(responseCode == HttpURLConnection.HTTP_MOVED_TEMP || responseCode == HttpURLConnection.HTTP_MOVED_PERM || responseCode == HttpURLConnection.HTTP_SEE_OTHER) {
				// Resource Moved				
				String temporaryLocation = connection.getHeaderField("Location");
				String cookies = connection.getHeaderField("Set-Cookie");
				
				connection = (HttpURLConnection) new URL(temporaryLocation).openConnection();
				connection.setRequestProperty("Cookie", cookies);
				connection.addRequestProperty("Accept-Language", "pl,en-US;q=0.7,en;q=0.3");
				connection.addRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0");
				connection.addRequestProperty("Referer", "google.com");
				
				is = connection.getInputStream();
			} else {
				is = connection.getErrorStream();
			}
			
			BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
			StringBuilder response = new StringBuilder();
			String line;
			
			while((line = br.readLine()) != null) {
				response.append(line);
			}
			
			br.close();
			
			return response.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	boolean isValidJSON(String jsonString);
	
	boolean isJSON(String jsonString);
}
