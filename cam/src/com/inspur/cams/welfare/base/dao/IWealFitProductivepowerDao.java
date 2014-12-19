package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.welfare.base.data.WealFitProductivepower;

/**
 * @title:IWealFitProductivepowerDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
 */
 public interface IWealFitProductivepowerDao extends BaseCURD<WealFitProductivepower>{
	public void save(List<WealFitProductivepower> list);

	public void deleteByTaskCode(String taskCode);
}

