package com.inspur.cams.bpt.bptelectronicfile.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IBptUploadfileDao
 * @description:
 * @author:
 * @since:2011-06-21
 * @version:1.0
*/
 public interface IBptUploadfileDao extends BaseCURD<BptUploadfile>{
	public void save(List<BptUploadfile> list);
}

