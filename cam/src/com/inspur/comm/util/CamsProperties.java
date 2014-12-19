package com.inspur.comm.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

/**
 * 对应classes目录下的bpt.properties文件
 */
public final class CamsProperties {
	private static final String LOCATION = "mems.properties";

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

	public static List getList(String key) {
		if (!hasLoad) {
			loadProperties(LOCATION);
		}
		List list = new ArrayList();
		if (key == null || key.equals(""))
			return list;
		Enumeration enums = properties.propertyNames();
		while (enums.hasMoreElements()) {
			String item = (String) enums.nextElement();
			if (item.indexOf(key) >= 0)
				list.add(properties.getProperty(item));

		}
		return list;
	}
}