package com.inspur.cams.jcm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IDicJcmManageDao;
import com.inspur.cams.jcm.data.DicJcmManage;
import com.inspur.cams.jcm.domain.IDicJcmManageDomain;

/**
 * 字典维护domain
 * @author 
 * @date 2014-05-22
 */
public class DicJcmManageDomain implements IDicJcmManageDomain {

	@Reference
	private IDicJcmManageDao dicJcmManageDao;

	/**
	 * 查询 字典维护
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicJcmManageDao.query(pset);
	}

	/**
	 * 获取 字典维护
	 * @param pset
	 * @return
	 */
	public DicJcmManage get(String dicType) {
		return dicJcmManageDao.get(dicType);
	}

	/**
	 * 增加 字典维护
	 * @param dicJcmManage
	 */
	public void insert(DicJcmManage dicJcmManage) {
		dicJcmManageDao.insert(dicJcmManage);
	}
	
	/**
	 * 修改 字典维护
	 * @param dicJcmManage
	 */
	public void update(DicJcmManage dicJcmManage) {
		dicJcmManageDao.update(dicJcmManage);
	}
	
	/**
	 * 删除 字典维护
	 * @param dicType
	 */
	public void delete(String dicType) {
		dicJcmManageDao.delete(dicType);
	}

}