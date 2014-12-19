package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 印章名录databean
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
@Table(tableName = "SOM_SIGNET_DIRECTORY", keyFields = "directoryId")
public class SomSignetDirectory extends StatefulDatabean {
	// 名录主键
	private String directoryId;

	// 印章ID
	private String id;

	// 印章名录
	private String directory;

	public String getDirectoryId() {
		return directoryId;
	}

	public void setDirectoryId(String directoryId) {
		this.directoryId = directoryId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDirectory() {
		return directory;
	}

	public void setDirectory(String directory) {
		this.directory = directory;
	}
}