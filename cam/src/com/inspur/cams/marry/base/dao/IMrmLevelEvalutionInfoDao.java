package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo;

/**
 * @title:IMrmLevelEvalutionInfoDao
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 public interface IMrmLevelEvalutionInfoDao extends BaseCURD<MrmLevelEvalutionInfo>{
	public void save(List<MrmLevelEvalutionInfo> list);
}

