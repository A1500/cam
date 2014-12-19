package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.base.dao.IFisDutyInfoDao;
import com.inspur.cams.fis.base.data.FisDutyInfo;
import com.inspur.cams.fis.base.domain.IFisDutyInfoDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisDutyInfoDomain  
 * @Description: TODO 殡葬业务人员岗位信息表Domain的实现
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public class FisDutyInfoDomain implements IFisDutyInfoDomain{

	 @Reference
	 private IFisDutyInfoDao fisDutyInfoDao;

	public void insert(FisDutyInfo bean) {
		// TODO Auto-generated method stub
		fisDutyInfoDao.insert(bean);
	}

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return fisDutyInfoDao.query(pset);
	}

	public void save(List<FisDutyInfo> list) {
		// TODO Auto-generated method stub
		fisDutyInfoDao.save(list);
	}

	public void update(FisDutyInfo bean) {
		// TODO Auto-generated method stub
		fisDutyInfoDao.update(bean);
	}

	public void delete(String key) {
		// TODO Auto-generated method stub
		fisDutyInfoDao.delete(key);
		
	}

	/**
	* @Title: queryForExport
	* @Description: TODO(数据上报导出数据方法)
	* @param set
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryForExport(ParameterSet set) {
		// TODO Auto-generated method stub
		return fisDutyInfoDao.queryForExport(set);
	}
}
