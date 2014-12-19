package com.inspur.cams.bpt.bptelectronicfile.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IBptElectronicListDao
 * @description:
 * @author:
 * @since:2011-07-15
 * @version:1.0
*/
 public interface IBptElectronicListDao extends BaseCURD<BptElectronicList>{
	public void save(List<BptElectronicList> list);
}

