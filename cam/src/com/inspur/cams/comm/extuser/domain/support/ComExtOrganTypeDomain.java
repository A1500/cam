package com.inspur.cams.comm.extuser.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.dao.IComExtOrganTypeDao;
import com.inspur.cams.comm.extuser.data.ComExtOrganType;
import com.inspur.cams.comm.extuser.domain.IComExtOrganTypeDomain;

/**
 * 外部单位类型domain实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganTypeDomain implements IComExtOrganTypeDomain {

	// 外部单位类型dao
	@Reference
	private IComExtOrganTypeDao comExtOrganTypeDao;
	
	/**
	 * 获取外部单位类型
	 * @param userId
	 * @return
	 */
	public ComExtOrganType getComExtOrganType(String code) {
		return comExtOrganTypeDao.getComExtOrganType(code);
	}
	
	/**
	 * 增加外部单位类型
	 * @param comExtUser
	 */
	@Trans
	public void insertComExtOrganType(ComExtOrganType comExtOrganType) {
		comExtOrganTypeDao.insertComExtOrganType(comExtOrganType);
	}
	
	/**
	 * 更新外部单位类型
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtOrganType(ComExtOrganType comExtOrganType) {
		comExtOrganTypeDao.updateComExtOrganType(comExtOrganType);
	}
	
	/**
	 * 删除外部单位类型
	 * @param userId
	 */
	@Trans
	public void deleteComExtOrganType(String code) {
		comExtOrganTypeDao.deleteComExtOrganType(code);
	}
	
	/**
	 * 查询外部单位类型
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrganType(ParameterSet ps) {
		return comExtOrganTypeDao.queryExtOrganType(ps);
	}
	
}
