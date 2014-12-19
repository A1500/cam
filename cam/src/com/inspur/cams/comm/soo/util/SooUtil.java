package com.inspur.cams.comm.soo.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.DaoFactory;

import com.inspur.cams.comm.soo.dao.PubCamsSooDao;
import com.inspur.cams.comm.soo.data.PubCamsSoo;

public class SooUtil {
	private static PubCamsSooDao dao = (PubCamsSooDao) DaoFactory
			.getDao("com.inspur.cams.comm.soo.dao.PubCamsSooDao");

	public static String getSooUserName(String sooType) {
		PubCamsSoo pubcamssoo = getSooInfo(sooType);
		String sooUserName = pubcamssoo.getUserName();
		return sooUserName;
	}

	public static String getSooPassword(String sooType) {
		PubCamsSoo pubcamssoo = getSooInfo(sooType);
		String password = pubcamssoo.getUserPassword();
		password = password.toLowerCase();
		return password;
	}

	public static PubCamsSoo getSooInfo(String sooType) {
		String localUserName = GetBspInfo.getBspInfo().getUserId();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("TYPE", sooType);
		map.put("LOCAL_USER_NAME", localUserName);
		List<PubCamsSoo> list = dao.queryNoPage(map);
		PubCamsSoo pubcamssoo = null;
		if (list.size() > 0) {
			pubcamssoo = (PubCamsSoo) list.get(0);
		} else {
			throw new RuntimeException("根据当前登陆用户:"+localUserName+" 类型:sooType ,"+"没有查询到对应的用户名或密码，请检查配置！");
		}
		return pubcamssoo;
	}

	public static String md5(String password) throws NoSuchAlgorithmException {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		byte[] strTemp = password.getBytes();
		// 使用MD5创建MessageDigest对象
		MessageDigest mdTemp = MessageDigest.getInstance("MD5");
		mdTemp.update(strTemp);
		byte[] md = mdTemp.digest();
		int j = md.length;
		char str[] = new char[j * 2];
		int k = 0;
		for (int i = 0; i < j; i++) {
			byte b = md[i];
			// System.out.println((int)b);
			// 将没个数(int)b进行双字节加密
			str[k++] = hexDigits[b >> 4 & 0xf];

			str[k++] = hexDigits[b & 0xf];
		}
		return new String(str);
	}

}
