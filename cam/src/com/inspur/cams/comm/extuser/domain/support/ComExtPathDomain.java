package com.inspur.cams.comm.extuser.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.dao.IComExtPathDao;
import com.inspur.cams.comm.extuser.data.ComExtPath;
import com.inspur.cams.comm.extuser.domain.IComExtPathDomain;

/**
 * 扩展页面路径配置domain实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtPathDomain implements IComExtPathDomain {

	// 扩展页面路径配置dao
	@Reference
	private IComExtPathDao comExtPathDao;
	
	/**
	 * 获取扩展页面路径配置
	 * @param userId
	 * @return
	 */
	public ComExtPath getComExtPath(String extPath) {
		return comExtPathDao.getComExtPath(extPath);
	}
	
	/**
	 * 增加扩展页面路径配置
	 * @param comExtUser
	 */
	@Trans
	public void insertComExtPath(ComExtPath comExtPath) {
		comExtPathDao.insertComExtPath(comExtPath);
	}
	
	/**
	 * 更新扩展页面路径配置
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtPath(ComExtPath comExtPath) {
		comExtPathDao.updateComExtPath(comExtPath);
	}
	
	/**
	 * 删除扩展页面路径配置
	 * @param userId
	 */
	@Trans
	public void deleteComExtPath(String extPath) {
		comExtPathDao.deleteComExtPath(extPath);
	}
	
	/**
	 * 查询扩展页面路径配置
	 * @param ps
	 * @return
	 */
	public DataSet queryExtPath(ParameterSet ps) {
		return comExtPathDao.queryExtPath(ps);
	}

}
