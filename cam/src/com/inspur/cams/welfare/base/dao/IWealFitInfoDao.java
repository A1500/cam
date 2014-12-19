package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.welfare.base.data.WealFitInfo;

/**
 * @title:IWealFitInfoDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitInfoDao extends BaseCURD<WealFitInfo>{
	public void save(List<WealFitInfo> list);
}

