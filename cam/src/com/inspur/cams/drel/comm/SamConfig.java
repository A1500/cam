package com.inspur.cams.drel.comm;

import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.StrUtil;

/**
 * 低保配置类
 * @author 闫亮亮
 *2012年11月6日
 */
public class SamConfig {
	/**
	 * 获取流程里面受理时是否进行文件上传校验
	 * 0：否 1：是
	 */
	 public static boolean getIfFileCheck(){
	    	String noNeedConnect = StrUtil.n2b(CamsProperties.getString("if_file_check"));
	    	if("0".equals(noNeedConnect)){
	    		return false;
	    	}else{
	    		return true;
	    	}
	    }
}
