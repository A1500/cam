package com.inspur.cams.drel.mbalance.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.mbalance.dao.ISamMServiceAreaDao;
import com.inspur.cams.drel.mbalance.data.SamMServiceArea;
import com.inspur.cams.drel.mbalance.domain.ISamMServiceAreaDomain;
/**
 * 
 * @author luguosui
 * 医院入院备案对象属地配置domain实现
 */

public class SamMServiceAreaDomain implements ISamMServiceAreaDomain {

	@Reference
	ISamMServiceAreaDao samMServiceAreaDao;
	
	public void delete(String[] delIds) {
		samMServiceAreaDao.batchDelete(delIds);
	}

	public void insert(SamMServiceArea dataBean) {
		samMServiceAreaDao.insert(dataBean);
	}

	public void save(List<SamMServiceArea> list) {
		samMServiceAreaDao.save(list);
	}

	public void update(SamMServiceArea dataBean) {
		samMServiceAreaDao.update(dataBean);
	}

	public DataSet query(ParameterSet pset) {
		return samMServiceAreaDao.query(pset);
	}

}

