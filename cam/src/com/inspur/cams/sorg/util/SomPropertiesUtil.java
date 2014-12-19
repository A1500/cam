package com.inspur.cams.sorg.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class SomPropertiesUtil {
	private static final String LOCATION = "cams_som.properties";
	private static Properties properties;
	private static boolean hasLoad = false;

	private static Properties loadProperties(String location) {
		InputStream in = null;
		try {
			// new InitAssistant().init();
			properties = new Properties();
			if (location.startsWith("/")) {
				location = location.substring(1);
			}
			ClassLoader ccl = Thread.currentThread().getContextClassLoader();
			in = ccl.getResourceAsStream(location);
			if (in != null) {
				properties.load(in);
				hasLoad = true;
			} else {
				throw new FileNotFoundException(location);
			}
			in.close();
		} catch (IOException e) {
			throw new RuntimeException("can't find the " + location);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
		}
		return properties;
	}

	public static String getString(String key) throws UnsupportedEncodingException {
		if (!hasLoad) {
			loadProperties(LOCATION);
		}
//		String value=properties.getProperty(key);
//		return new String(value.getBytes("UTF-8"),"gbk");
		return properties.getProperty(key);
	}
}
