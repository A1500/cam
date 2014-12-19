package com.inspur.cams.welfare.config.device.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

/**
 * @title:IWealDicFitdeviceDao
 * @description:
 * @author:
 * @since:2013-04-25
 * @version:1.0
*/
 public interface IWealDicFitdeviceDao extends BaseCURD<WealDicFitdevice>{
	public void save(List<WealDicFitdevice> list);
}

