package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomSessionDao;
import com.inspur.cams.sorg.base.dao.jdbc.SomSessionDao;
import com.inspur.cams.sorg.base.data.SomSession;
import com.inspur.cams.sorg.base.domain.ISomSessionDomain;

/**
 * 社会组织届次domain
 * @author zhangjian
 * @date 2011-9-21
 */
public class SomSessionDomain implements ISomSessionDomain {
	
	@Reference
	private ISomSessionDao somSessionDao;

	/**
	 * 查询届次信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somSessionDao.query(pset);
	}

	/**
	 * 查询当前届次信息
	 * @return
	 */
	public DataSet getCurrentSession(String sorgId) {
		return somSessionDao.getCurrentSession(sorgId);
	}
	
	/**
	 * 增加届次信息
	 * @param somSession
	 */
	public void insert(SomSession somSession) {
		somSessionDao.insert(somSession);
	}
	
	/**
	 * 更新届次信息
	 * @param somSession
	 */
	public void update(SomSession somSession) {
		somSessionDao.update(somSession);
	}
	/**
	 * 查询该登记证号的社会组织下面是否存在填写的届次名称
	 * @param sorgCode 登记证号
	 * @param sessionName  届次名称
	 * @param sorgId  sorgId
	 */
	public DataSet findIfExist(String sorgCode, String sessionName,String sorgId) {
		return somSessionDao.findIfExist(sorgCode,sessionName,sorgId);
	}

}
