package com.steamcentral.core.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * Simple interface which implements default method of web resource download.
 * Contains methods signatures of validating {@link java.lang.String} type variable in JSON format - all of them should be implemented by user.
 * 
 * @author Jakub Podgórski
 *
 */
public interface HttpConnection {

	/**
	 * Connects to web source via given URL address and downloads given resource. 
	 * If HTTP response code: 301, 302, 303 occurs method reconnects and downloads content from changed location.
	 * 
	 * @param url the URL address of web content to download.
	 * @return downloaded web content.
	 */
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
	
	/**
	 * This method formulates the check of String value obtained from web source which should contains 'success' object and be proper string of characters in JSON format.
	 * 
	 * @param jsonString the string of characters to check.
	 * @return true if given string of characters contains 'success' object set to true, false otherwise.
	 */
	boolean isValidJSON(String jsonString);
	
	/**
	 * This method formulates the check of String value which should be one of the admissible types in JSON format (JSONArray, JSONObject).
	 * 
	 * @param jsonString the string of characters to check.
	 * @return true if given string of characters is one of the JSON types, false otherwise.
	 */
	boolean isJSON(String jsonString);
}
