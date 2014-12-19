package com.inspur.sdmz.disasterInfo.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IDisasterInfoDao
 * @description:
 * @author:
 * @since:2011-09-13
 * @version:1.0
*/
 public interface IDisasterInfoDao extends BaseCURD<DisasterInfo>{
	public void save(List<DisasterInfo> list);
}

