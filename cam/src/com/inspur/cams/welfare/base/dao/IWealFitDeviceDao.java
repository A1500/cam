package com.inspur.cams.welfare.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.welfare.base.data.WealFitDevice;

/**
 * @title:IWealFitDeviceDao
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
 public interface IWealFitDeviceDao extends BaseCURD<WealFitDevice>{
	public void save(List<WealFitDevice> list);
	/**
	 * 假矫设施基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportDeviceInfo(ParameterSet pset);
}

