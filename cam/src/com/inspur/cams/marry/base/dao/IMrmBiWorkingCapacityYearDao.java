package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmBiWorkingCapacityYear;

/**
 * @title:IMrmBiWorkingCapacityYearDao
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
 public interface IMrmBiWorkingCapacityYearDao extends BaseCURD<MrmBiWorkingCapacityYear>{
	public void save(List<MrmBiWorkingCapacityYear> list);
}

