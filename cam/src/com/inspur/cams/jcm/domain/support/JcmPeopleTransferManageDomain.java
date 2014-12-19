package com.inspur.cams.jcm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmPeopleTransferManageDao;
import com.inspur.cams.jcm.data.JcmPeopleTransferManage;
import com.inspur.cams.jcm.domain.IJcmPeopleTransferManageDomain;

/**
 * 人员管理表domain
 * @author
 * @date 2014-12-15
 */
public class JcmPeopleTransferManageDomain implements IJcmPeopleTransferManageDomain {

	@Reference
	private IJcmPeopleTransferManageDao jcmPeopleTransferManageDao;

	/**
	 * 查询 人员管理表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmPeopleTransferManageDao.query(pset);
	}

	/**
	 * 获取 人员管理表
	 * @param pset
	 * @return
	 */
	public JcmPeopleTransferManage get(String id) {
		return jcmPeopleTransferManageDao.get(id);
	}

	/**
	 * 增加 人员管理表
	 * @param JcmPeopleTransferManage
	 */
	public void insert(JcmPeopleTransferManage jcmPeopleTransferManage) {
		jcmPeopleTransferManageDao.insert(jcmPeopleTransferManage);
	}
	
	/**
	 * 修改 人员管理表
	 * @param JcmPeopleTransferManage
	 */
	public void update(JcmPeopleTransferManage jcmPeopleTransferManage) {
		jcmPeopleTransferManageDao.update(jcmPeopleTransferManage);
	}
	
	/**
	 * 删除 人员管理表
	 * @param id
	 */
	public void delete(String id) {
		jcmPeopleTransferManageDao.delete(id);
	}
	/**
	 * 保存 人员管理表
	 * @param equList
	 */
	public void save(List equList) {
		jcmPeopleTransferManageDao.save(equList);
	}

}