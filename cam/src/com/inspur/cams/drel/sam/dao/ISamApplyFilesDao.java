package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamApplyFiles;

/**
 * @title:申请材料Dao
 * @description:
 * @author:
 * @since:2012-05-05
 * @version:1.0
*/
 public interface ISamApplyFilesDao extends BaseCURD<SamApplyFiles>{
	public void save(List<SamApplyFiles> list);
}

