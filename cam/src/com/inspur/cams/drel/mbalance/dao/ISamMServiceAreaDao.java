package com.inspur.cams.drel.mbalance.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.mbalance.data.SamMServiceArea;



public interface ISamMServiceAreaDao extends BaseCURD<SamMServiceArea>{
	/**
	 * 保存配置信息
	 */
	public void save(List<SamMServiceArea> list);
}