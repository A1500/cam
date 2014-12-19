package com.inspur.cams.drel.config.assistance.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.config.assistance.dao.ISamAssistanceItemDao;
import com.inspur.cams.drel.config.assistance.data.SamAssistanceItem;
import com.inspur.cams.drel.config.assistance.domain.ISamAssistanceItemDomain;

/**
 * @title:救助项目Domain接口
 * @description:
 * @author:
 * @date:2012年5月29日
 * @version:1.0
 */
public class SamAssistanceItemDomain implements ISamAssistanceItemDomain {
	@Reference
	private ISamAssistanceItemDao samAssistanceItemDao;

	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samAssistanceItemDao.query(pset);
	}

	/**
	 * 增加
	 * 
	 * @param samAssistanceItem
	 */
	public void insert(SamAssistanceItem samAssistanceItem) {
		samAssistanceItemDao.insert(samAssistanceItem);
	}

	/**
	 * 更新
	 * 
	 * @param samAssistanceItem
	 */
	public void update(SamAssistanceItem samAssistanceItem) {
		samAssistanceItemDao.update(samAssistanceItem);
	}
}
