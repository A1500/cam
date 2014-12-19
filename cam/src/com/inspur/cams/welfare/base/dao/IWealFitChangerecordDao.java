package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.welfare.base.data.WealFitChangerecord;

/**
 * @title:IWealFitChangerecordDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitChangerecordDao extends BaseCURD<WealFitChangerecord>{
	public void save(List<WealFitChangerecord> list);
}

