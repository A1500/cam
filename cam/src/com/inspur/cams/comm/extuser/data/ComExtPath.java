package com.inspur.cams.comm.extuser.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 扩展页面路径配置表
 * @author shgtch
 * @date 2011-6-28
 */
@Table(tableName = "COM_EXT_PATH", keyFields = "extPath")
public class ComExtPath extends StatefulDatabean {

	// 路径
	private String extPath;

	public String getExtPath() {
		return extPath;
	}

	public void setExtPath(String extPath) {
		this.extPath = extPath;
	}
	
}
