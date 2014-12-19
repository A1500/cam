package com.inspur.cams.comm.comfile.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.comfile.data.ComFile;

public interface IComFileDao extends BaseCURD<ComFile> {
	
	public ComFile insertPhoto(ComFile comFile);
	
}
