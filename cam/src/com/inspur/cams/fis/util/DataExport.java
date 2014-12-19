package com.inspur.cams.fis.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.Security;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class DataExport {
	
	protected static final Log logger = LogFactory.getLog(com.inspur.cams.fis.util.DataExport.class);
	
	/**
	 * @Description:
	 * @author xuexzh
	 */

	public static void main(String[] args) {
		String sqls = "GRANT SELECT ANY TABLE TO cams WITH ADMIN OPTION; \nGRANT UNLIMITED TABLESPACE TO cams WITH ADMIN OPTION;";
		
		try {
			//decode(sqls, "D:\\output");
//			String re = encode("D:\\output", "BZ370100-01");
//			System.out.println(re);
			
			Key key = createKey("BZ370125-01");
//			System.out.println(byteArr2Str(key.getEncoded()));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public final static String CHARSET_NAME = "utf-8"; // 字符集

	/**
	 * @Description: 加密，参数（sql语句集，加密后生成文件路径）
	 * @author xuexzh
	 */
	public static void decode(String sqls, String deFile, String pk) throws Exception {
		Key key = createKey(pk);
		byte[] orgData = sqls.getBytes(CHARSET_NAME);
		byte[] raw = doEncrypt(key, orgData);
		File file = new File(deFile);
		FileOutputStream out = new FileOutputStream(file);
		out.write(raw);  //加密
//		out.write(orgData);	//不加密
		out.close();
//		System.out.println("成功加密!");
	}
	
	/**
	 * @Description: 解密，参数（已加密的文件）
	 * @author xuexzh
	 */
	public static String encode(String enFile, String pk) throws Exception {
		Key key = createKey(pk);
		File file = new File(enFile);
		FileInputStream fis = new FileInputStream(file);
		InputStream raw = doDecrypt(key, fis);
		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		byte[] tmpbuf = new byte[1024];
		int count = 0;
		while ((count = raw.read(tmpbuf)) != -1) {
			bout.write(tmpbuf, 0, count);
			tmpbuf = new byte[1024];
		}
		raw.close();
		String sqls = new String(bout.toByteArray(), CHARSET_NAME);
//		System.out.println("成功解密!");
		return sqls;
	}

	/**
	 * @Description: 对数据进行加密
	 * @author xuexzh
	 */
	private static byte[] doEncrypt(Key key, byte[] data) {
		try {
			Cipher cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] raw = cipher.doFinal(data);
			return raw;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	/**
	 * @Description: 对数据进行解密
	 * @author xuexzh
	 */
	public static InputStream doDecrypt(Key key, InputStream in) {
		try {
			Cipher cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.DECRYPT_MODE, key);
			ByteArrayOutputStream bout = new ByteArrayOutputStream();
			byte[] tmpbuf = new byte[1024];
			int count = 0;
			while ((count = in.read(tmpbuf)) != -1) {
				bout.write(tmpbuf, 0, count);
				tmpbuf = new byte[1024];
			}
			in.close();
			byte[] orgData = bout.toByteArray();
			byte[] raw = cipher.doFinal(orgData);
			ByteArrayInputStream bin = new ByteArrayInputStream(raw);
			return bin;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	private static String byteArr2Str(byte[] b) {
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(int i=0; i<b.length; i++) {
			sb.append(b[i]).append(",");			
		}
		if(sb.length() > 2)
			sb.deleteCharAt(sb.length()-1);
		sb.append("]");
		return sb.toString();
	}
	/**
	 * @Description: 进行解密，参数（已加密的文件内容）
	 * @author xuexzh
	 */
	public static String encodeContent(byte[] enFileContent, String pk, StringBuffer log) throws Exception {
		log.append("\n解密类，开始..."+pk);
//		Key key2 = createKey(pk);
//		log.append("\n测试密钥..."+key2.getFormat()+" "+key2.getAlgorithm()+" "+key2.getEncoded().length);
//		log.append("\n\t"+byteArr2Str(key2.getEncoded()));
		
		//add
		String privateKey = pk+getPrivateKey();
		if (privateKey == null)
			throw new NoSuchAlgorithmException();
		Security.insertProviderAt(new com.sun.crypto.provider.SunJCE(), 1);
		log.append("\n插入首选算法...版本："+new com.sun.crypto.provider.SunJCE().getInfo());
		KeyGenerator generator = KeyGenerator.getInstance("DES");
		log.append("\n实例化DES算法...");
		log.append("\n："+byteArr2Str(privateKey.getBytes("UTF-8")));
		
		SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG"); 
		secureRandom.setSeed(privateKey.getBytes("UTF-8")); 
		log.append("\n生成随机源..."+secureRandom.getProvider().getInfo()+" "+secureRandom.getProvider().getVersion());
		log.append("\n"+secureRandom.getAlgorithm());
		generator.init(secureRandom);
		Key key = generator.generateKey();

		log.append("\n再次得到密钥..."+key.getFormat()+" "+key.getAlgorithm()+" "+key.getEncoded().length);
		log.append("\n\t"+byteArr2Str(key.getEncoded()));
		//...
		
		Cipher cipher = Cipher.getInstance("DES");
		log.append("\n已获取算法...");
		cipher.init(Cipher.DECRYPT_MODE, key);
		log.append("\n已初始化算法...");
		byte[] raw = cipher.doFinal(enFileContent);
		log.append("\n已执行算法...");
		String sqls = new String(raw, CHARSET_NAME);
		log.append("\n已成功解密!结果转换 byte[]-->String...");
		return sqls;
	}

	/**
	 * @Description: 创建密钥，用于加密
	 * @author xuexzh
	 */
	public static Key createKey(String pk) throws NoSuchAlgorithmException {
		String privateKey = pk+getPrivateKey();
		if (privateKey == null)
			throw new NoSuchAlgorithmException();
		Security.insertProviderAt(new com.sun.crypto.provider.SunJCE(), 1);
		KeyGenerator generator = KeyGenerator.getInstance("DES");
		generator.init(new SecureRandom(privateKey.getBytes()));
		Key key = generator.generateKey();
		return key;
	}

	/**
	 * @Description: 生成私钥
	 * @author xuexzh
	 */
	public static String getPrivateKey() {
		return "FIS_SD";
	}
}
