package com.inspur.cams.sorg.jxcheck.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class JxCheckProperties {
	private static final String LOCATION = "somJxCheckDba.properties";
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

	public static String getString(String key) {
		if (!hasLoad) {
			loadProperties(LOCATION);
		}
		return properties.getProperty(key);
	}
}
