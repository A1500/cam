package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmResourcesInfo;

/**
 * @title:IMrmResourcesInfoDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public interface IMrmResourcesInfoDao extends BaseCURD<MrmResourcesInfo>{
	public void save(List<MrmResourcesInfo> list);
}

