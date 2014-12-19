package com.inspur.cams.fis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.base.data.FisGlobalConfig;

/**
 * @title:IFisGlobalConfigDao
 * @description:
 * @author:
 * @since:2011-12-15
 * @version:1.0
*/
 public interface IFisGlobalConfigDao extends BaseCURD<FisGlobalConfig>{
	public void save(List<FisGlobalConfig> list);
	public void deleteAllTable();
}

