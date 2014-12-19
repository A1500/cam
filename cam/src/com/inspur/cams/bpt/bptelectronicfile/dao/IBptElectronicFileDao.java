package com.inspur.cams.bpt.bptelectronicfile.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IBptElectronicFileDao
 * @description:
 * @author:
 * @since:2011-06-27
 * @version:1.0
*/
 public interface IBptElectronicFileDao extends BaseCURD<BptElectronicFile>{
	public void save(List<BptElectronicFile> list);
}

